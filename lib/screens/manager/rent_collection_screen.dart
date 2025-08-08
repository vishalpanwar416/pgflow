import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerRentCollectionScreen extends StatefulWidget {
  final String assignedPG;
  
  const ManagerRentCollectionScreen({super.key, required this.assignedPG});

  @override
  State<ManagerRentCollectionScreen> createState() => _ManagerRentCollectionScreenState();
}

class _ManagerRentCollectionScreenState extends State<ManagerRentCollectionScreen> {
  String _selectedMonth = 'December 2024';
  String _selectedStatus = 'All';

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
      'room': '101',
      'amount': 5000,
      'status': 'Paid',
      'dueDate': '15/12/2024',
      'paidDate': '10/12/2024',
      'color': Colors.green,
    },
    {
      'tenant': 'Jane Smith',
      'room': '102',
      'amount': 5000,
      'status': 'Pending',
      'dueDate': '15/12/2024',
      'paidDate': null,
      'color': Colors.orange,
    },
    {
      'tenant': 'Mike Johnson',
      'room': '103',
      'amount': 5000,
      'status': 'Overdue',
      'dueDate': '15/12/2024',
      'paidDate': null,
      'color': Colors.red,
    },
    {
      'tenant': 'Sarah Wilson',
      'room': '104',
      'amount': 5000,
      'status': 'Paid',
      'dueDate': '15/12/2024',
      'paidDate': '12/12/2024',
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalAmount = _rentals.fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));
    final paidAmount = _rentals.where((r) => r['status'] == 'Paid').fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));
    final pendingAmount = _rentals.where((r) => r['status'] == 'Pending').fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));
    final overdueAmount = _rentals.where((r) => r['status'] == 'Overdue').fold<int>(0, (sum, rental) => sum + (rental['amount'] as int));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Rent Collection',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.orange),
            onPressed: () => _showComingSoon(context),
            tooltip: 'Export',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PG Info Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.home_work, color: Colors.orange, size: 28),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.assignedPG,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Rent Collection',
                          style: GoogleFonts.poppins(
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),
            // Summary Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total Rent', '₹${totalAmount.toStringAsFixed(0)}', Icons.payment, Colors.blue),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Paid', '₹${paidAmount.toStringAsFixed(0)}', Icons.check_circle, Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Pending', '₹${pendingAmount.toStringAsFixed(0)}', Icons.pending_actions, Colors.orange),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Overdue', '₹${overdueAmount.toStringAsFixed(0)}', Icons.warning, Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 28.0),
            // Filters
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filters',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedMonth,
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.orange,
                          style: GoogleFonts.poppins(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Month',
                            labelStyle: GoogleFonts.poppins(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          items: _months.map((month) => DropdownMenuItem(
                            value: month,
                            child: Text(month),
                          )).toList(),
                          onChanged: (value) => setState(() => _selectedMonth = value!),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.orange,
                          style: GoogleFonts.poppins(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Status',
                            labelStyle: GoogleFonts.poppins(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          items: _statuses.map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          )).toList(),
                          onChanged: (value) => setState(() => _selectedStatus = value!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),
            // Rentals List
            Text(
              'Rent Collection',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            ..._rentals.map((rental) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildRentalCard(rental),
            )),
            const SizedBox(height: 28.0),
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showComingSoon(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Send Reminders',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showComingSoon(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Generate Report',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRentalCard(Map<String, dynamic> rental) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
                    color: Colors.white,
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Room ${rental['room']}',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
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
                      color: Colors.white,
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
                        color: Colors.white,
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
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      rental['dueDate'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
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
                          color: Colors.white70,
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
                        foregroundColor: Colors.white,
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
                        foregroundColor: Colors.white,
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