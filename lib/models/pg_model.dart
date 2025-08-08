import 'package:hive/hive.dart';

part 'pg_model.g.dart';

@HiveType(typeId: 1)
class PG extends HiveObject {
  @HiveField(0)
  final String pgId;

  @HiveField(1)
  final String ownerId;

  @HiveField(2)
  final String pgName;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final int totalRooms;

  @HiveField(6)
  final int occupiedRooms;

  @HiveField(7)
  final List<String> amenities;

  @HiveField(8)
  final List<String> rules;

  PG({
    required this.pgId,
    required this.ownerId,
    required this.pgName,
    required this.address,
    required this.createdAt,
    this.totalRooms = 0,
    this.occupiedRooms = 0,
    this.amenities = const [],
    this.rules = const [],
  });

  factory PG.fromJson(Map<String, dynamic> json) {
    return PG(
      pgId: json['pg_id'],
      ownerId: json['owner_id'],
      pgName: json['pg_name'] ?? '',
      address: json['address'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      totalRooms: json['total_rooms'] ?? 0,
      occupiedRooms: json['occupied_rooms'] ?? 0,
      amenities: List<String>.from(json['amenities'] ?? []),
      rules: List<String>.from(json['rules'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pg_id': pgId,
      'owner_id': ownerId,
      'pg_name': pgName,
      'address': address,
      'created_at': createdAt.toIso8601String(),
      'total_rooms': totalRooms,
      'occupied_rooms': occupiedRooms,
      'amenities': amenities,
      'rules': rules,
    };
  }

  PG copyWith({
    String? pgId,
    String? ownerId,
    String? pgName,
    String? address,
    DateTime? createdAt,
    int? totalRooms,
    int? occupiedRooms,
    List<String>? amenities,
    List<String>? rules,
  }) {
    return PG(
      pgId: pgId ?? this.pgId,
      ownerId: ownerId ?? this.ownerId,
      pgName: pgName ?? this.pgName,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      totalRooms: totalRooms ?? this.totalRooms,
      occupiedRooms: occupiedRooms ?? this.occupiedRooms,
      amenities: amenities ?? this.amenities,
      rules: rules ?? this.rules,
    );
  }

  int get availableRooms => totalRooms - occupiedRooms;
  double get occupancyRate => totalRooms > 0 ? (occupiedRooms / totalRooms) * 100 : 0;
} 