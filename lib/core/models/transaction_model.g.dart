// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      listingId: json['listingId'] as String,
      bidId: json['bidId'] as String?,
      escrowId: json['escrowId'] as String?,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      amount: (json['amount'] as num).toInt(),
      fee: (json['fee'] as num?)?.toInt(),
      netAmount: (json['netAmount'] as num?)?.toInt(),
      currency: json['currency'] as String,
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      paymentIntentId: json['paymentIntentId'] as String?,
      chargeId: json['chargeId'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      failureReason: json['failureReason'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      refundedAt: json['refundedAt'] == null
          ? null
          : DateTime.parse(json['refundedAt'] as String),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'listingId': instance.listingId,
      'bidId': instance.bidId,
      'escrowId': instance.escrowId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'amount': instance.amount,
      'fee': instance.fee,
      'netAmount': instance.netAmount,
      'currency': instance.currency,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'paymentIntentId': instance.paymentIntentId,
      'chargeId': instance.chargeId,
      'receiptUrl': instance.receiptUrl,
      'failureReason': instance.failureReason,
      'description': instance.description,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'refundedAt': instance.refundedAt?.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.purchase: 'purchase',
  TransactionType.refund: 'refund',
  TransactionType.escrowDeposit: 'escrowDeposit',
  TransactionType.escrowRelease: 'escrowRelease',
  TransactionType.escrowRefund: 'escrowRefund',
  TransactionType.fee: 'fee',
  TransactionType.payout: 'payout',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.processing: 'processing',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
  TransactionStatus.disputed: 'disputed',
  TransactionStatus.refunded: 'refunded',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.card: 'card',
  PaymentMethod.bankTransfer: 'bankTransfer',
  PaymentMethod.wallet: 'wallet',
  PaymentMethod.applePay: 'applePay',
  PaymentMethod.googlePay: 'googlePay',
};

_$EscrowModelImpl _$$EscrowModelImplFromJson(Map<String, dynamic> json) =>
    _$EscrowModelImpl(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      listingId: json['listingId'] as String,
      amount: (json['amount'] as num).toInt(),
      status: json['status'] as String,
      releaseConditions: json['releaseConditions'] as String?,
      fundedAt: json['fundedAt'] == null
          ? null
          : DateTime.parse(json['fundedAt'] as String),
      releasedAt: json['releasedAt'] == null
          ? null
          : DateTime.parse(json['releasedAt'] as String),
      refundedAt: json['refundedAt'] == null
          ? null
          : DateTime.parse(json['refundedAt'] as String),
      disputedAt: json['disputedAt'] == null
          ? null
          : DateTime.parse(json['disputedAt'] as String),
      disputeReason: json['disputeReason'] as String?,
      resolutionNotes: json['resolutionNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EscrowModelImplToJson(_$EscrowModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'listingId': instance.listingId,
      'amount': instance.amount,
      'status': instance.status,
      'releaseConditions': instance.releaseConditions,
      'fundedAt': instance.fundedAt?.toIso8601String(),
      'releasedAt': instance.releasedAt?.toIso8601String(),
      'refundedAt': instance.refundedAt?.toIso8601String(),
      'disputedAt': instance.disputedAt?.toIso8601String(),
      'disputeReason': instance.disputeReason,
      'resolutionNotes': instance.resolutionNotes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$PayoutModelImpl _$$PayoutModelImplFromJson(Map<String, dynamic> json) =>
    _$PayoutModelImpl(
      id: json['id'] as String,
      sellerId: json['sellerId'] as String,
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      stripePayoutId: json['stripePayoutId'] as String?,
      bankAccountId: json['bankAccountId'] as String?,
      failureReason: json['failureReason'] as String?,
      transactionIds: (json['transactionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      estimatedArrival: json['estimatedArrival'] == null
          ? null
          : DateTime.parse(json['estimatedArrival'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
    );

Map<String, dynamic> _$$PayoutModelImplToJson(_$PayoutModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'stripePayoutId': instance.stripePayoutId,
      'bankAccountId': instance.bankAccountId,
      'failureReason': instance.failureReason,
      'transactionIds': instance.transactionIds,
      'estimatedArrival': instance.estimatedArrival?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'paidAt': instance.paidAt?.toIso8601String(),
      'failedAt': instance.failedAt?.toIso8601String(),
    };
