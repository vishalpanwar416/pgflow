import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TenantCard extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String pgName;
  final String roomNumber;
  final double rent;
  final String status;
  final String joinDate;
  final Color statusColor;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onViewDetails;

  const TenantCard({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.pgName,
    required this.roomNumber,
    required this.rent,
    required this.status,
    required this.joinDate,
    required this.statusColor,
    this.onEdit,
    this.onDelete,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty
        ? name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join()
        : 'TN';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onViewDetails,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[50]!,
                Colors.grey[100]!,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        initials,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Room: $roomNumber • $pgName',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Divider(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn(
                    icon: Icons.phone_android_rounded,
                    value: phone,
                    context: context,
                  ),
                  _buildInfoColumn(
                    icon: Icons.email_rounded,
                    value: '${email.split('@').first}\n@${email.split('@').last}',
                    context: context,
                    maxLines: 2,
                  ),
                  _buildInfoColumn(
                    icon: Icons.calendar_today_rounded,
                    value: 'Joined\n$joinDate',
                    context: context,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹$rent/month',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined, size: 20),
                        color: Colors.grey[600],
                        onPressed: onViewDetails,
                        tooltip: 'View Details',
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 20),
                        color: Colors.blue[600],
                        onPressed: onEdit,
                        tooltip: 'Edit Tenant',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 20),
                        color: Colors.red[600],
                        onPressed: onDelete,
                        tooltip: 'Delete Tenant',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
    required IconData icon,
    required String value,
    required BuildContext context,
    int maxLines = 1,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 4.0),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey[700],
              height: 1.2,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
