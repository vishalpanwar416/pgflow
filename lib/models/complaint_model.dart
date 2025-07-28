import 'package:hive/hive.dart';

part 'complaint_model.g.dart';

@HiveType(typeId: 4)
class Complaint extends HiveObject {
  @HiveField(0)
  final String complaintId;

  @HiveField(1)
  final String tenantId;

  @HiveField(2)
  final String issue;

  @HiveField(3)
  final String status; // 'open' or 'resolved'

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? resolvedAt;

  @HiveField(6)
  final String? resolution;

  @HiveField(7)
  final String category; // 'wifi', 'water', 'electricity', 'maintenance', 'other'

  @HiveField(8)
  final String? priority; // 'low', 'medium', 'high', 'urgent'

  Complaint({
    required this.complaintId,
    required this.tenantId,
    required this.issue,
    this.status = 'open',
    required this.createdAt,
    this.resolvedAt,
    this.resolution,
    this.category = 'other',
    this.priority = 'medium',
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      complaintId: json['complaint_id'],
      tenantId: json['tenant_id'],
      issue: json['issue'] ?? '',
      status: json['status'] ?? 'open',
      createdAt: DateTime.parse(json['created_at']),
      resolvedAt: json['resolved_at'] != null 
          ? DateTime.parse(json['resolved_at']) 
          : null,
      resolution: json['resolution'],
      category: json['category'] ?? 'other',
      priority: json['priority'] ?? 'medium',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complaint_id': complaintId,
      'tenant_id': tenantId,
      'issue': issue,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'resolved_at': resolvedAt?.toIso8601String(),
      'resolution': resolution,
      'category': category,
      'priority': priority,
    };
  }

  Complaint copyWith({
    String? complaintId,
    String? tenantId,
    String? issue,
    String? status,
    DateTime? createdAt,
    DateTime? resolvedAt,
    String? resolution,
    String? category,
    String? priority,
  }) {
    return Complaint(
      complaintId: complaintId ?? this.complaintId,
      tenantId: tenantId ?? this.tenantId,
      issue: issue ?? this.issue,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolution: resolution ?? this.resolution,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }

  bool get isOpen => status == 'open';
  bool get isResolved => status == 'resolved';
  
  int get daysOpen {
    final endDate = resolvedAt ?? DateTime.now();
    return endDate.difference(createdAt).inDays;
  }

  String get priorityColor {
    switch (priority) {
      case 'urgent':
        return '#FF0000';
      case 'high':
        return '#FF6B35';
      case 'medium':
        return '#FFA500';
      case 'low':
        return '#32CD32';
      default:
        return '#FFA500';
    }
  }
} 