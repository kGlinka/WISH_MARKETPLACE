import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

interface BidRankingInput {
  wishId: string;
  userBudgetMax: number;
  userBudgetMin: number;
  urgency: 'low' | 'medium' | 'high';
}

interface ScoredBid {
  bidId: string;
  score: number;
  breakdown: {
    priceScore: number;
    ratingScore: number;
    etaScore: number;
    responseScore: number;
  };
}

export const rankBids = functions.https.onCall(
  async (data: BidRankingInput, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User must be authenticated'
      );
    }

    const { wishId, userBudgetMax, userBudgetMin, urgency } = data;

    try {
      // Get all pending bids for this wish
      const bidsSnapshot = await admin
        .firestore()
        .collection('wishes')
        .doc(wishId)
        .collection('bids')
        .where('status', '==', 'pending')
        .get();

      const scoredBids: ScoredBid[] = [];

      for (const bidDoc of bidsSnapshot.docs) {
        const bid = bidDoc.data();

        // Calculate individual scores
        const priceScore = calculatePriceScore(
          bid.price,
          userBudgetMin,
          userBudgetMax
        );
        const ratingScore = calculateRatingScore(bid.providerRating);
        const etaScore = calculateEtaScore(bid.eta.toDate(), urgency);
        const responseScore = calculateResponseScore(
          bid.providerResponseTime || 30
        );

        // Calculate weighted total
        const totalScore =
          priceScore * 0.4 +
          ratingScore * 0.3 +
          etaScore * 0.2 +
          responseScore * 0.1;

        scoredBids.push({
          bidId: bidDoc.id,
          score: totalScore,
          breakdown: {
            priceScore,
            ratingScore,
            etaScore,
            responseScore,
          },
        });

        // Update bid with ranking score
        await bidDoc.ref.update({ rankingScore: totalScore });
      }

      // Sort by score (descending)
      scoredBids.sort((a, b) => b.score - a.score);

      return scoredBids;
    } catch (error) {
      console.error('Error ranking bids:', error);
      throw new functions.https.HttpsError('internal', 'Error ranking bids');
    }
  }
);

// Helper functions
function calculatePriceScore(
  bidPrice: number,
  minBudget: number,
  maxBudget: number
): number {
  const budgetMidpoint = (minBudget + maxBudget) / 2;
  const budgetRange = maxBudget - minBudget;

  if (bidPrice > maxBudget) {
    return Math.max(0, 1 - (bidPrice - maxBudget) / budgetRange);
  } else if (bidPrice < minBudget) {
    return 0.8;
  } else {
    const distanceFromMidpoint = Math.abs(bidPrice - budgetMidpoint);
    const normalizedDistance = distanceFromMidpoint / (budgetRange / 2);
    return 1 - normalizedDistance * 0.2;
  }
}

function calculateRatingScore(rating: number): number {
  return rating / 5.0;
}

function calculateEtaScore(eta: Date, urgency: string): number {
  const now = new Date();
  const hoursUntilEta = (eta.getTime() - now.getTime()) / (1000 * 60 * 60);

  let idealHours: number;
  switch (urgency) {
    case 'high':
      idealHours = 2;
      break;
    case 'medium':
      idealHours = 12;
      break;
    case 'low':
      idealHours = 48;
      break;
    default:
      idealHours = 24;
  }

  if (hoursUntilEta <= idealHours) {
    return 1.0;
  } else {
    const excessHours = hoursUntilEta - idealHours;
    return Math.max(0, 1 - excessHours / (idealHours * 2));
  }
}

function calculateResponseScore(avgResponseMinutes: number): number {
  if (avgResponseMinutes <= 5) return 1.0;
  if (avgResponseMinutes <= 15) return 0.9;
  if (avgResponseMinutes <= 30) return 0.8;
  if (avgResponseMinutes <= 60) return 0.7;
  if (avgResponseMinutes <= 120) return 0.6;
  return 0.5;
}
