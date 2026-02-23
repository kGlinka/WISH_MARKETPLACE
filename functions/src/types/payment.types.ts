/**
 * Payment-related TypeScript types for type safety
 */

export enum EscrowStatus {
  PENDING = 'pending',
  AUTHORIZED = 'authorized',
  FUNDED = 'funded',
  RELEASED = 'released',
  REFUNDED = 'refunded',
  DISPUTED = 'disputed',
  CANCELLED = 'cancelled',
}

export enum TransactionStatus {
  PENDING = 'pending',
  PROCESSING = 'processing',
  COMPLETED = 'completed',
  FAILED = 'failed',
  CANCELLED = 'cancelled',
  DISPUTED = 'disputed',
  REFUNDED = 'refunded',
}

export enum TransactionType {
  PURCHASE = 'purchase',
  REFUND = 'refund',
  ESCROW_DEPOSIT = 'escrowDeposit',
  ESCROW_RELEASE = 'escrowRelease',
  ESCROW_REFUND = 'escrowRefund',
  FEE = 'fee',
  PAYOUT = 'payout',
}

export interface CreatePaymentIntentData {
  bidId: string;
  wishId: string;
  amount: number; // Amount in cents
  currency?: string;
  description?: string;
  metadata?: Record<string, string>;
}

export interface ReleaseEscrowData {
  transactionId: string;
  releaseAmount?: number; // Optional partial release
  reason?: string;
}

export interface RefundEscrowData {
  transactionId: string;
  refundAmount?: number; // Optional partial refund
  reason: string;
}

export interface DisputeEscrowData {
  transactionId: string;
  reason: string;
  evidence?: Record<string, any>;
}

export interface WebhookEventData {
  type: string;
  data: {
    object: any;
  };
  created: number;
  id: string;
}

export interface EscrowRecord {
  id: string;
  transactionId: string;
  buyerId: string;
  sellerId: string;
  wishId: string;
  bidId: string;
  amount: number;
  status: EscrowStatus;
  paymentIntentId: string;
  chargeId?: string;
  releaseConditions?: string;
  fundedAt?: Date;
  releasedAt?: Date;
  refundedAt?: Date;
  disputedAt?: Date;
  disputeReason?: string;
  resolutionNotes?: string;
  createdAt: Date;
  updatedAt?: Date;
}

export interface TransactionRecord {
  id: string;
  userId: string;
  wishId: string;
  bidId?: string;
  escrowId?: string;
  type: TransactionType;
  status: TransactionStatus;
  amount: number; // in cents
  fee?: number; // platform fee in cents
  netAmount?: number; // amount after fees in cents
  currency: string;
  paymentMethod: string;
  paymentIntentId?: string;
  chargeId?: string;
  receiptUrl?: string;
  failureReason?: string;
  description?: string;
  metadata?: Record<string, any>;
  createdAt: Date;
  completedAt?: Date;
  cancelledAt?: Date;
  refundedAt?: Date;
}
