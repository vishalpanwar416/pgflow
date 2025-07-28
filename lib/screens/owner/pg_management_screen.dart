import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PGManagementScreen extends StatefulWidget {
  const PGManagementScreen({super.key});

  @override
  State<PGManagementScreen> createState() => _PGManagementScreenState();
}

class _PGManagementScreenState extends State<PGManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pgNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _totalRoomsController = TextEditingController();
  final _rentController = TextEditingController();

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
  Widget build(BuildContext context) {
    final totalRooms = _pgs.fold<int>(0, (sum, pg) => sum + (pg['totalRooms'] as int));
    final occupiedRooms = _pgs.fold<int>(0, (sum, pg) => sum + (pg['occupiedRooms'] as int));
    final totalRent = _pgs.fold<int>(0, (sum, pg) => sum + (pg['monthlyRent'] as int));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'PG Management',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.orange),
            onPressed: () => _showAddPGDialog(context),
            tooltip: 'Add PG',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total PGs', '${_pgs.length}', Icons.home_work),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Total Rooms', '$totalRooms', Icons.meeting_room),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Occupied', '$occupiedRooms', Icons.people),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Vacant', '${totalRooms - occupiedRooms}', Icons.meeting_room_outlined),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Monthly Rent', '₹${totalRent.toStringAsFixed(0)}', Icons.payment),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Occupancy', '${((occupiedRooms / totalRooms) * 100).toStringAsFixed(0)}%', Icons.analytics),
                ),
              ],
            ),
            const SizedBox(height: 28.0),
            // PG List
            Text(
              'My PGs',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            ..._pgs.map((pg) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildPGCard(pg),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 24),
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

  Widget _buildPGCard(Map<String, dynamic> pg) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.08),
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
              Expanded(
                child: Text(
                  pg['name'],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: pg['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pg['status'],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.orange, size: 16),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  pg['address'],
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              _buildInfoChip('${pg['occupiedRooms']}/${pg['totalRooms']} Rooms', Colors.blue),
              const SizedBox(width: 8.0),
              _buildInfoChip('₹${pg['monthlyRent']}/month', Colors.green),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
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
                    'Edit',
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
                    'View Details',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showAddPGDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Add New PG',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _pgNameController,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'PG Name',
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
                validator: (value) => value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Address',
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
                validator: (value) => value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _totalRoomsController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Total Rooms',
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
                      validator: (value) => value?.isEmpty == true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _rentController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Monthly Rent',
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
                      validator: (value) => value?.isEmpty == true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('PG added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Add PG',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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