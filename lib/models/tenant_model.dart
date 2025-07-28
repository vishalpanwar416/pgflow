import 'package:hive/hive.dart';

part 'tenant_model.g.dart';

@HiveType(typeId: 2)
class Tenant extends HiveObject {
  @HiveField(0)
  final String tenantId;

  @HiveField(1)
  final String pgId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double rent;

  @HiveField(4)
  final String roomNo;

  @HiveField(5)
  final DateTime joinDate;

  @HiveField(6)
  final DateTime? leaveDate;

  @HiveField(7)
  final String phone;

  @HiveField(8)
  final String email;

  @HiveField(9)
  final bool isActive;

  Tenant({
    required this.tenantId,
    required this.pgId,
    required this.name,
    required this.rent,
    required this.roomNo,
    required this.joinDate,
    this.leaveDate,
    required this.phone,
    required this.email,
    this.isActive = true,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      tenantId: json['tenant_id'],
      pgId: json['pg_id'],
      name: json['name'] ?? '',
      rent: (json['rent'] ?? 0).toDouble(),
      roomNo: json['room_no'] ?? '',
      joinDate: DateTime.parse(json['join_date']),
      leaveDate: json['leave_date'] != null 
          ? DateTime.parse(json['leave_date']) 
          : null,
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenant_id': tenantId,
      'pg_id': pgId,
      'name': name,
      'rent': rent,
      'room_no': roomNo,
      'join_date': joinDate.toIso8601String(),
      'leave_date': leaveDate?.toIso8601String(),
      'phone': phone,
      'email': email,
      'is_active': isActive,
    };
  }

  Tenant copyWith({
    String? tenantId,
    String? pgId,
    String? name,
    double? rent,
    String? roomNo,
    DateTime? joinDate,
    DateTime? leaveDate,
    String? phone,
    String? email,
    bool? isActive,
  }) {
    return Tenant(
      tenantId: tenantId ?? this.tenantId,
      pgId: pgId ?? this.pgId,
      name: name ?? this.name,
      rent: rent ?? this.rent,
      roomNo: roomNo ?? this.roomNo,
      joinDate: joinDate ?? this.joinDate,
      leaveDate: leaveDate ?? this.leaveDate,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
    );
  }

  int get daysStayed {
    final endDate = leaveDate ?? DateTime.now();
    return endDate.difference(joinDate).inDays;
  }

  bool get hasNotice => leaveDate != null;
} 