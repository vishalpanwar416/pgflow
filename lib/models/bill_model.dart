import 'package:hive/hive.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 3)
class Bill extends HiveObject {
  @HiveField(0)
  final String billId;

  @HiveField(1)
  final String tenantId;

  @HiveField(2)
  final DateTime month;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final bool paid;

  @HiveField(5)
  final DateTime dueDate;

  @HiveField(6)
  final DateTime? paidDate;

  @HiveField(7)
  final String? paymentMethod;

  @HiveField(8)
  final String? transactionId;

  Bill({
    required this.billId,
    required this.tenantId,
    required this.month,
    required this.amount,
    this.paid = false,
    required this.dueDate,
    this.paidDate,
    this.paymentMethod,
    this.transactionId,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      billId: json['bill_id'],
      tenantId: json['tenant_id'],
      month: DateTime.parse(json['month']),
      amount: (json['amount'] ?? 0).toDouble(),
      paid: json['paid'] ?? false,
      dueDate: DateTime.parse(json['due_date']),
      paidDate: json['paid_date'] != null 
          ? DateTime.parse(json['paid_date']) 
          : null,
      paymentMethod: json['payment_method'],
      transactionId: json['transaction_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bill_id': billId,
      'tenant_id': tenantId,
      'month': month.toIso8601String(),
      'amount': amount,
      'paid': paid,
      'due_date': dueDate.toIso8601String(),
      'paid_date': paidDate?.toIso8601String(),
      'payment_method': paymentMethod,
      'transaction_id': transactionId,
    };
  }

  Bill copyWith({
    String? billId,
    String? tenantId,
    DateTime? month,
    double? amount,
    bool? paid,
    DateTime? dueDate,
    DateTime? paidDate,
    String? paymentMethod,
    String? transactionId,
  }) {
    return Bill(
      billId: billId ?? this.billId,
      tenantId: tenantId ?? this.tenantId,
      month: month ?? this.month,
      amount: amount ?? this.amount,
      paid: paid ?? this.paid,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  bool get isOverdue => !paid && DateTime.now().isAfter(dueDate);
  
  int get daysOverdue {
    if (!isOverdue) return 0;
    return DateTime.now().difference(dueDate).inDays;
  }

  String get status {
    if (paid) return 'Paid';
    if (isOverdue) return 'Overdue';
    return 'Pending';
  }

  String get monthYear => '${month.month}/${month.year}';
} 