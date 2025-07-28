import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String role; // 'owner', 'manager', 'tenant'

  @HiveField(5)
  final String? pgId; // null for owner, assigned PG for manager

  @HiveField(6)
  final String? roomNo; // only for tenants

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final List<String> managedPGs; // list of PG IDs for owner

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    this.pgId,
    this.roomNo,
    required this.createdAt,
    this.managedPGs = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      pgId: json['pg_id'],
      roomNo: json['room_no'],
      createdAt: DateTime.parse(json['created_at']),
      managedPGs: List<String>.from(json['managed_pgs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
      'pg_id': pgId,
      'room_no': roomNo,
      'created_at': createdAt.toIso8601String(),
      'managed_pgs': managedPGs,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? role,
    String? pgId,
    String? roomNo,
    DateTime? createdAt,
    List<String>? managedPGs,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      pgId: pgId ?? this.pgId,
      roomNo: roomNo ?? this.roomNo,
      createdAt: createdAt ?? this.createdAt,
      managedPGs: managedPGs ?? this.managedPGs,
    );
  }

  bool get isOwner => role == 'owner';
  bool get isManager => role == 'manager';
  bool get isTenant => role == 'tenant';
} 