import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'base_owner_screen.dart';
import '../../theme/owner_theme.dart';
import '../../widgets/owner/owner_card.dart';

class RentCollectionScreen extends StatefulWidget {
  const RentCollectionScreen({super.key});

  @override
  State<RentCollectionScreen> createState() => _RentCollectionScreenState();
}

class _RentCollectionScreenState extends State<RentCollectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedPG = 'All PGs';
  String _selectedMonth = 'December 2024';
  String _selectedStatus = 'All';

  final List<String> _pgs = ['All PGs', 'Sunshine PG', 'Royal PG', 'Comfort PG'];
  final List<String> _months = [
    'December 2024',
    'November 2024',
    'October 2024',
    'September 2024',
  ];
  final List<String> _statuses = ['All', 'Paid', 'Pending', 'Overdue'];

  final List<Map<String, dynamic>> _rentals = [
    {
      'tenant': 'John Doe',
      'pg': 'Sunshine PG',
      'room': '101',
      'amount': 5000,
      'status': 'Paid',
      'dueDate': '15/12/2024',
      'paidDate': '10/12/2024',
      'color': Colors.green,
    },
    {
      'tenant': 'Jane Smith',
      'pg': 'Sunshine PG',
      'room': '102',
      'amount': 5000,
      'status': 'Pending',
      'dueDate': '15/12/2024',
      'paidDate': null,
      'color': Colors.orange,
    },
    {
      'tenant': 'Mike Johnson',
      'pg': 'Royal PG',
      'room': '201',
      'amount': 6000,
      'status': 'Overdue',
      'dueDate': '15/12/2024',
      'paidDate': null,
      'color': Colors.red,
    },
    {
      'tenant': 'Sarah Wilson',
      'pg': 'Comfort PG',
      'room': '301',
      'amount': 4500,
      'status': 'Paid',
      'dueDate': '15/12/2024',
      'paidDate': '12/12/2024',
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _rentals.fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));
    final paidAmount = _rentals.where((r) => r['status'] == 'Paid').fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));
    final pendingAmount = _rentals.where((r) => r['status'] == 'Pending').fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));
    final overdueAmount = _rentals.where((r) => r['status'] == 'Overdue').fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));

    return BaseOwnerScreen(
      title: 'Rent Collection',
      actions: [
        IconButton(
          icon: const Icon(Icons.download, color: Color(0xFF667EEA)),
          onPressed: () => _showComingSoon(context),
          tooltip: 'Export',
        ),
      ],
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
                'Total',
                '₹$totalAmount',
                Icons.payments_rounded,
                const Color(0xFF667EEA),
              ),
              _buildStatCard(
                'Paid',
                '₹$paidAmount',
                Icons.check_circle_rounded,
                const Color(0xFF10B981),
              ),
              _buildStatCard(
                'Pending',
                '₹$pendingAmount',
                Icons.pending_rounded,
                const Color(0xFFF59E0B),
              ),
              _buildStatCard(
                'Overdue',
                '₹$overdueAmount',
                Icons.warning_rounded,
                const Color(0xFFEF4444),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Filters
          ModernCard(
            padding: OwnerTheme.paddingLarge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: OwnerTheme.textStyleHeading3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedPG,
                        dropdownColor: OwnerTheme.colorSurface,
                        iconEnabledColor: OwnerTheme.colorPrimary,
                        style: OwnerTheme.textStyleBody1,
                        decoration: OwnerTheme.inputDecoration(labelText: 'PG'),
                        items: _pgs.map((pg) => DropdownMenuItem(
                          value: pg,
                          child: Text(pg),
                        )).toList(),
                        onChanged: (value) => setState(() => _selectedPG = value!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedMonth,
                        dropdownColor: OwnerTheme.colorSurface,
                        iconEnabledColor: OwnerTheme.colorPrimary,
                        style: OwnerTheme.textStyleBody1,
                        decoration: OwnerTheme.inputDecoration(labelText: 'Month'),
                        items: _months.map((month) => DropdownMenuItem(
                          value: month,
                          child: Text(month),
                        )).toList(),
                        onChanged: (value) => setState(() => _selectedMonth = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  dropdownColor: OwnerTheme.colorSurface,
                  iconEnabledColor: OwnerTheme.colorPrimary,
                  style: OwnerTheme.textStyleBody1,
                  decoration: OwnerTheme.inputDecoration(labelText: 'Status'),
                  items: _statuses.map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  )).toList(),
                  onChanged: (value) => setState(() => _selectedStatus = value!),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Rentals List
          Text(
            'Rent Collection',
            style: OwnerTheme.textStyleHeading3,
          ),
          const SizedBox(height: 16),
          ..._rentals.map((rental) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildRentalCard(rental),
          )),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showComingSoon(context),
                  style: OwnerTheme.buttonStylePrimary,
                  child: Text(
                    'Send Reminders',
                    style: OwnerTheme.textStyleButton,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showComingSoon(context),
                  style: OwnerTheme.buttonStyleOutline,
                  child: Text(
                    'Generate Report',
                    style: OwnerTheme.textStyleButton,
                  ),
                ),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: OwnerTheme.animationDurationMedium).slideY(
        begin: 0.1, 
        end: 0, 
        curve: Curves.easeOutQuad,
        duration: OwnerTheme.animationDurationMedium
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return StatCard(
      title: title,
      value: value,
      icon: icon,
      iconColor: color,
    );
  }

  Widget _buildRentalCard(Map<String, dynamic> rental) {
    return ModernCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.orange,
                child: Text(
                  rental['tenant'].split(' ').map((e) => e[0]).join(''),
                  style: GoogleFonts.poppins(
                    color: Colors.black, // Changed from white to black
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rental['tenant'],
                      style: GoogleFonts.poppins(
                        color: Colors.black, // Changed from white to black
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${rental['pg']} - Room ${rental['room']}',
                      style: GoogleFonts.poppins(
                        color: Colors.black54, // Changed from white70 to black54
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${rental['amount']}',
                    style: GoogleFonts.poppins(
                      color: Colors.black, // Changed from white to black
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: rental['color'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      rental['status'],
                      style: GoogleFonts.poppins(
                        color: Colors.black, // Changed from white to black
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due Date',
                      style: GoogleFonts.poppins(
                        color: Colors.black54, // Changed from white70 to black54
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      rental['dueDate'],
                      style: GoogleFonts.poppins(
                        color: Colors.black, // Changed from white to black
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (rental['paidDate'] != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paid Date',
                        style: GoogleFonts.poppins(
                          color: Colors.black54, // Changed from white70 to black54
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        rental['paidDate'],
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (rental['status'] != 'Paid')
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showComingSoon(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black, // Changed from white to black
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Mark as Paid',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showComingSoon(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black, // Changed from white to black
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.white30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Send Reminder',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}