import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Transaction type enum
enum TransactionType {
  purchase,
  refund,
  escrowDeposit,
  escrowRelease,
  escrowRefund,
  fee,
  payout,
}

/// Transaction status enum
enum TransactionStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  disputed,
  refunded,
}

/// Payment method enum
enum PaymentMethod {
  card,
  bankTransfer,
  wallet,
  applePay,
  googlePay,
}

/// Transaction model representing a payment transaction
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String userId,
    required String listingId,
    String? bidId,
    String? escrowId,
    required TransactionType type,
    required TransactionStatus status,
    required int amount, // in cents
    int? fee, // platform fee in cents
    int? netAmount, // amount after fees in cents
    required String currency,
    required PaymentMethod paymentMethod,
    String? paymentIntentId, // Stripe payment intent ID
    String? chargeId, // Stripe charge ID
    String? receiptUrl,
    String? failureReason,
    String? description,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    DateTime? refundedAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

/// Escrow model for secure payment holding
@freezed
class EscrowModel with _$EscrowModel {
  const factory EscrowModel({
    required String id,
    required String transactionId,
    required String buyerId,
    required String sellerId,
    required String listingId,
    required int amount, // in cents
    required String status, // pending, funded, released, refunded, disputed
    String? releaseConditions,
    DateTime? fundedAt,
    DateTime? releasedAt,
    DateTime? refundedAt,
    DateTime? disputedAt,
    String? disputeReason,
    String? resolutionNotes,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _EscrowModel;

  factory EscrowModel.fromJson(Map<String, dynamic> json) =>
      _$EscrowModelFromJson(json);
}

/// Payout model for seller payments
@freezed
class PayoutModel with _$PayoutModel {
  const factory PayoutModel({
    required String id,
    required String sellerId,
    required int amount, // in cents
    required String currency,
    required String status, // pending, processing, paid, failed
    String? stripePayoutId,
    String? bankAccountId,
    String? failureReason,
    List<String>? transactionIds, // list of transaction IDs included
    DateTime? estimatedArrival,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? failedAt,
  }) = _PayoutModel;

  factory PayoutModel.fromJson(Map<String, dynamic> json) =>
      _$PayoutModelFromJson(json);
}
