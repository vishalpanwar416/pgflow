import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerTenantManagementScreen extends StatefulWidget {
  final String assignedPG;
  
  const ManagerTenantManagementScreen({super.key, required this.assignedPG});

  @override
  State<ManagerTenantManagementScreen> createState() => _ManagerTenantManagementScreenState();
}

class _ManagerTenantManagementScreenState extends State<ManagerTenantManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _roomController = TextEditingController();
  final _rentController = TextEditingController();
  String _selectedStatus = 'Active';

  final List<String> _statuses = ['Active', 'Inactive', 'Pending'];

  final List<Map<String, dynamic>> _tenants = [
    {
      'name': 'John Doe',
      'phone': '+91 98765 43210',
      'email': 'john.doe@example.com',
      'room': '101',
      'rent': 5000,
      'status': 'Active',
      'joinDate': '01/01/2024',
      'color': Colors.green,
    },
    {
      'name': 'Jane Smith',
      'phone': '+91 98765 43211',
      'email': 'jane.smith@example.com',
      'room': '102',
      'rent': 5000,
      'status': 'Active',
      'joinDate': '15/01/2024',
      'color': Colors.green,
    },
    {
      'name': 'Mike Johnson',
      'phone': '+91 98765 43212',
      'email': 'mike.johnson@example.com',
      'room': '103',
      'rent': 5000,
      'status': 'Pending',
      'joinDate': '01/02/2024',
      'color': Colors.orange,
    },
    {
      'name': 'Sarah Wilson',
      'phone': '+91 98765 43213',
      'email': 'sarah.wilson@example.com',
      'room': '104',
      'rent': 5000,
      'status': 'Active',
      'joinDate': '15/02/2024',
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalTenants = _tenants.length;
    final activeTenants = _tenants.where((t) => t['status'] == 'Active').length;
    final totalRent = _tenants.fold<int>(0, (sum, tenant) => sum + (tenant['rent'] as int));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Tenant Management',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.orange),
            onPressed: () => _showAddTenantDialog(context),
            tooltip: 'Add Tenant',
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
                          'Managing Tenants',
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
                  child: _buildStatCard('Total Tenants', '$totalTenants', Icons.people),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Active', '$activeTenants', Icons.check_circle),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Monthly Rent', '₹${totalRent.toStringAsFixed(0)}', Icons.payment),
                ),
              ],
            ),
            const SizedBox(height: 28.0),
            // Search and Filter
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
                    'Search & Filter',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
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
                ],
              ),
            ),
            const SizedBox(height: 28.0),
            // Tenants List
            Text(
              'All Tenants',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            ..._tenants.map((tenant) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildTenantCard(tenant),
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
            color: Colors.orange.withValues(alpha: 0.08),
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

  Widget _buildTenantCard(Map<String, dynamic> tenant) {
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
                  tenant['name'].split(' ').map((e) => e[0]).join(''),
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
                      tenant['name'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      tenant['email'],
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: tenant['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tenant['status'],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              _buildInfoChip('Room ${tenant['room']}', Colors.blue),
              const SizedBox(width: 8.0),
              _buildInfoChip('₹${tenant['rent']}/month', Colors.green),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.orange, size: 16),
              const SizedBox(width: 8.0),
              Text(
                tenant['phone'],
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                'Joined: ${tenant['joinDate']}',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
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
        color: color.withValues(alpha: 0.2),
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

  void _showAddTenantDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Add New Tenant',
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
                controller: _nameController,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Full Name',
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
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
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
                      controller: _roomController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Room Number',
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
                    content: Text('Tenant added successfully!'),
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
              'Add Tenant',
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