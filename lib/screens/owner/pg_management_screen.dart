import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_owner_screen.dart';

class PGManagementScreen extends StatefulWidget {
  const PGManagementScreen({super.key});

  @override
  State<PGManagementScreen> createState() => _PGManagementScreenState();
}

class _PGManagementScreenState extends State<PGManagementScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _pgNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _totalRoomsController = TextEditingController();
  final _rentController = TextEditingController();
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _pgs = [
    {
      'name': 'Sunshine PG',
      'address': '123 Main Street, City',
      'totalRooms': 20,
      'occupiedRooms': 18,
      'monthlyRent': 5000,
      'status': 'Active',
      'color': Colors.green,
    },
    {
      'name': 'Royal PG',
      'address': '456 Park Avenue, City',
      'totalRooms': 15,
      'occupiedRooms': 12,
      'monthlyRent': 6000,
      'status': 'Active',
      'color': Colors.green,
    },
    {
      'name': 'Comfort PG',
      'address': '789 Lake Road, City',
      'totalRooms': 25,
      'occupiedRooms': 20,
      'monthlyRent': 4500,
      'status': 'Active',
      'color': Colors.green,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pgNameController.dispose();
    _addressController.dispose();
    _totalRoomsController.dispose();
    _rentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalRooms = _pgs.fold<int>(0, (sum, pg) => sum + (pg['totalRooms'] as int));
    final occupiedRooms = _pgs.fold<int>(0, (sum, pg) => sum + (pg['occupiedRooms'] as int));
    final totalRent = _pgs.fold<int>(0, (sum, pg) => sum + (pg['monthlyRent'] as int));
    final occupancyRate = totalRooms > 0 ? (occupiedRooms / totalRooms) * 100 : 0;

    return BaseOwnerScreen(
      title: 'PG Management',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPGDialog(context),
        backgroundColor: const Color(0xFF667EEA),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text(
          'Add PG',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        icon: const Icon(Icons.add_rounded, size: 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard(
                'Total PGs',
                '${_pgs.length}',
                Icons.home_work_rounded,
                const Color(0xFF667EEA),
              ),
              _buildStatCard(
                'Total Rooms',
                '$totalRooms',
                Icons.meeting_room_rounded,
                const Color(0xFF10B981),
              ),
              _buildStatCard(
                'Occupied',
                '$occupiedRooms',
                Icons.people_rounded,
                const Color(0xFFF59E0B),
              ),
              _buildStatCard(
                'Vacant',
                '${totalRooms - occupiedRooms}',
                Icons.meeting_room_outlined,
                const Color(0xFF3B82F6),
              ),
              _buildStatCard(
                'Monthly Rent',
                '₹${totalRent.toStringAsFixed(0)}',
                Icons.payments_rounded,
                const Color(0xFF8B5CF6),
              ),
              _buildStatCard(
                'Occupancy',
                '${occupancyRate.toStringAsFixed(1)}%',
                Icons.analytics_rounded,
                const Color(0xFFEC4899),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // PG List Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My PGs',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                '${_pgs.length} Properties',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // PG List
          ..._pgs.asMap().entries.map((entry) {
            final index = entry.key;
            final pg = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildPGCard(pg, index),
            ).animate(
              controller: _animationController,
              delay: Duration(milliseconds: 100 + (index * 50)),
            ).fadeIn().slideY(
              begin: 0.3,
              end: 0,
              curve: Curves.easeOutCubic,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return ModernCard(
      padding: const EdgeInsets.all(16),
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPGCard(Map<String, dynamic> pg, int index) {
    final occupancyRate = (pg['occupiedRooms'] / pg['totalRooms']) * 100;
    final progressColor = occupancyRate > 80 
        ? const Color(0xFFEF4444) 
        : occupancyRate > 50 
            ? const Color(0xFFF59E0B) 
            : const Color(0xFF10B981);

    return ModernCard(
      onTap: () {
        // Navigate to PG details
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.home_work_rounded,
                  color: Color(0xFF667EEA),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pg['name'],
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pg['address'],
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: progressColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  pg['status'],
                  style: GoogleFonts.inter(
                    color: progressColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Occupancy Progress
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Occupancy',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${occupancyRate.toStringAsFixed(1)}%',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: occupancyRate / 100,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${pg['occupiedRooms']} occupied',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  Text(
                    '${pg['totalRooms'] - pg['occupiedRooms']} vacant',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Footer with actions
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  '₹${pg['monthlyRent']}',
                  'Monthly Rent',
                  Icons.payments_rounded,
                  const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoChip(
                  '${pg['totalRooms']} Rooms',
                  'Total Capacity',
                  Icons.meeting_room_rounded,
                  const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.more_vert_rounded, size: 20, color: Color(0xFF64748B)),
                  padding: EdgeInsets.zero,
                  onPressed: () => _showPGMenu(context, pg),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPGDialog(BuildContext context) {
    _pgNameController.clear();
    _addressController.clear();
    _totalRoomsController.clear();
    _rentController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Add New PG',
          style: GoogleFonts.inter(
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _pgNameController,
                  style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    labelText: 'PG Name',
                    labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PG name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _totalRoomsController,
                        style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Total Rooms',
                          labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final rooms = int.tryParse(value);
                          if (rooms == null || rooms <= 0) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _rentController,
                        style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '₹ ',
                          labelText: 'Monthly Rent',
                          labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final rent = int.tryParse(value);
                          if (rent == null || rent <= 0) {
                            return 'Invalid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final newPG = {
                  'name': _pgNameController.text,
                  'address': _addressController.text,
                  'totalRooms': int.parse(_totalRoomsController.text),
                  'occupiedRooms': 0,
                  'monthlyRent': int.parse(_rentController.text),
                  'status': 'Active',
                  'color': Colors.green,
                };

                setState(() {
                  _pgs.add(newPG);
                });

                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('PG added successfully!'),
                    backgroundColor: const Color(0xFF10B981),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Add PG',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> pg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Delete ${pg['name']}?',
          style: GoogleFonts.inter(
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this PG? This action cannot be undone.',
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _pgs.removeWhere((p) => p['name'] == pg['name']);
              });
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${pg['name']} has been deleted'),
                  backgroundColor: const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPGMenu(BuildContext context, Map<String, dynamic> pg) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildMenuOption(
              context,
              icon: Icons.edit_rounded,
              label: 'Edit PG',
              color: const Color(0xFF3B82F6),
              onTap: () {
                Navigator.pop(context);
                _showEditPGDialog(context, pg);
              },
            ),
            const SizedBox(height: 12),
            _buildMenuOption(
              context,
              icon: Icons.people_alt_rounded,
              label: 'Manage Tenants',
              color: const Color(0xFF8B5CF6),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement manage tenants navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tenant management coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildMenuOption(
              context,
              icon: Icons.history_rounded,
              label: 'View Rent History',
              color: const Color(0xFFF59E0B),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement rent history navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rent history coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            _buildMenuOption(
              context,
              icon: Icons.delete_rounded,
              label: 'Delete PG',
              color: const Color(0xFFEF4444),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, pg);
              },
              isDestructive: true,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDestructive ? const Color(0xFFFEE2E2) : color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDestructive ? const Color(0xFFFECACA) : color.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDestructive ? const Color(0xFFFECACA) : color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? const Color(0xFFDC2626) : color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? const Color(0xFFB91C1C) : const Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isDestructive ? const Color(0xFFB91C1C) : const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPGDialog(BuildContext context, Map<String, dynamic> pg) {
    _pgNameController.text = pg['name'];
    _addressController.text = pg['address'];
    _totalRoomsController.text = pg['totalRooms'].toString();
    _rentController.text = pg['monthlyRent'].toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Edit ${pg['name']}',
          style: GoogleFonts.inter(
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _pgNameController,
                  style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    labelText: 'PG Name',
                    labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PG name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _totalRoomsController,
                        style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Total Rooms',
                          labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final rooms = int.tryParse(value);
                          if (rooms == null || rooms <= 0) {
                            return 'Invalid number';
                          }
                          if (rooms < pg['occupiedRooms']) {
                            return 'Cannot be less than ${pg['occupiedRooms']}';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _rentController,
                        style: GoogleFonts.inter(color: const Color(0xFF1E293B)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '₹ ',
                          labelText: 'Monthly Rent',
                          labelStyle: GoogleFonts.inter(color: const Color(0xFF64748B)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final rent = int.tryParse(value);
                          if (rent == null || rent <= 0) {
                            return 'Invalid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final updatedPG = {
                  'name': _pgNameController.text,
                  'address': _addressController.text,
                  'totalRooms': int.parse(_totalRoomsController.text),
                  'occupiedRooms': pg['occupiedRooms'],
                  'monthlyRent': int.parse(_rentController.text),
                  'status': pg['status'],
                  'color': pg['color'],
                };

                setState(() {
                  final index = _pgs.indexWhere((p) => p['name'] == pg['name']);
                  if (index != -1) {
                    _pgs[index] = updatedPG;
                  }
                });

                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('PG updated successfully!'),
                    backgroundColor: const Color(0xFF10B981),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Save Changes',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}