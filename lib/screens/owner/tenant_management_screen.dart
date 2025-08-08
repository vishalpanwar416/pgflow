import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_owner_screen.dart';

class TenantManagementScreen extends StatefulWidget {
  const TenantManagementScreen({super.key});

  @override
  State<TenantManagementScreen> createState() => _TenantManagementScreenState();
}

class _TenantManagementScreenState extends State<TenantManagementScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _roomController = TextEditingController();
  final _rentController = TextEditingController();
  late AnimationController _animationController;
  String _selectedPG = 'Sunshine PG';
  String _selectedStatus = 'Active';

  final List<String> _pgs = ['Sunshine PG', 'Royal PG', 'Comfort PG'];
  final List<String> _statuses = ['Active', 'Inactive', 'Pending'];
  
  // Add this getter to calculate inactive tenants
  int get inactiveTenants => _tenants.where((t) => t['status'] == 'Inactive').length;
  int get activeTenants => _tenants.where((t) => t['status'] == 'Active').length;
  int get totalTenants => _tenants.length;
  double get totalRent => _tenants.fold(0, (sum, tenant) => sum + (tenant['rent'] as double));
  final List<Map<String, dynamic>> _tenants = [
    {
      'name': 'John Doe',
      'phone': '+91 98765 43210',
      'email': 'john.doe@example.com',
      'pg': 'Sunshine PG',
      'room': '101',
      'rent': 5000.0,
      'status': 'Active',
      'joinDate': '01/01/2024',
      'color': Colors.green,
    },
    {
      'name': 'Jane Smith',
      'phone': '+91 98765 43211',
      'email': 'jane.smith@example.com',
      'pg': 'Sunshine PG',
      'room': '102',
      'rent': 5000.0,
      'status': 'Active',
      'joinDate': '15/01/2024',
      'color': Colors.green,
    },
    {
      'name': 'Mike Johnson',
      'phone': '+91 98765 43212',
      'email': 'mike.johnson@example.com',
      'pg': 'Royal PG',
      'room': '201',
      'rent': 6000.0,
      'status': 'Active',
      'joinDate': '01/02/2024',
      'color': Colors.green,
    },
    {
      'name': 'Sarah Wilson',
      'phone': '+91 98765 43213',
      'email': 'sarah.wilson@example.com',
      'pg': 'Comfort PG',
      'room': '301',
      'rent': 4500.0,
      'status': 'Pending',
      'joinDate': '01/03/2024',
      'color': Colors.orange,
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
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _roomController.dispose();
    _rentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate tenant statistics
    final totalTenants = _tenants.length;
    final activeTenants = _tenants.where((t) => t['status'] == 'Active').length;
    final inactiveTenants = _tenants.where((t) => t['status'] == 'Inactive').length;
    final totalRent = _tenants.fold(0.0, (sum, tenant) => sum + (tenant['rent'] as double));
    
    return BaseOwnerScreen(
      title: 'Tenant Management',
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.analytics, color: Color(0xFF667EEA)),
          ),
          onPressed: () => _showComingSoon(context),
          tooltip: 'Analytics',
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Grid with animation
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard('Total Tenants', '$totalTenants', Icons.people_outline),
                _buildStatCard('Active', '$activeTenants', Icons.check_circle_outline),
                _buildStatCard('Inactive', '$inactiveTenants', Icons.highlight_off_outlined),
                _buildStatCard('Monthly Rent', '₹${totalRent.toStringAsFixed(0)}', Icons.payment_outlined),
              ],
            ),
            
            const SizedBox(height: 24),
          
            // Search and Filter Card
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.filter_alt_outlined, color: Colors.blue.shade700, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Search & Filter',
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade100.withValues(alpha: 0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _selectedPG,
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.blueGrey),
                            iconSize: 20,
                            elevation: 4,
                            style: GoogleFonts.poppins(
                              color: Colors.blueGrey.shade800,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Select PG',
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.blueGrey.shade600,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                            items: _pgs.map((pg) => DropdownMenuItem(
                              value: pg,
                              child: Text(
                                pg,
                                style: GoogleFonts.poppins(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 14,
                                ),
                              ),
                            )).toList(),
                            onChanged: (value) => setState(() => _selectedPG = value!),
                            ),
                          ),
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100.withValues(alpha: 0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedStatus,
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.blueGrey),
                            iconSize: 20,
                            elevation: 4,
                            style: GoogleFonts.poppins(
                              color: Colors.blueGrey.shade800,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Status',
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.blueGrey.shade600,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                            items: _statuses.map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(
                                status,
                                style: GoogleFonts.poppins(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 14,
                                ),
                              ),
                            )).toList(),
                            onChanged: (value) => setState(() => _selectedStatus = value!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // All Tenants
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              'All Tenants',
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: List.generate(_tenants.length, (index) {
              final tenant = _tenants[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildTenantCard(tenant),
              );
            }),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    // Get color based on title
    Color getStatColor() {
      switch (title) {
        case 'Total Tenants': return const Color(0xFF667EEA);
        case 'Active': return const Color(0xFF10B981);
        case 'Inactive': return const Color(0xFFEF4444);
        case 'Monthly Rent': return const Color(0xFFF59E0B);
        default: return const Color(0xFF667EEA);
      }
    }

    final statColor = getStatColor();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: statColor,
                    size: 24,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
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

  Widget _buildTenantCard(Map<String, dynamic> tenant) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    tenant['name'].toString().split(' ').map((e) => e[0]).join(''),
                    style: GoogleFonts.poppins(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Tenant Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tenant['name'],
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: tenant['status'] == 'Active' 
                                ? Colors.green.shade50 
                                : tenant['status'] == 'Inactive'
                                    ? Colors.red.shade50
                                    : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: tenant['status'] == 'Active' 
                                  ? Colors.green.shade200 
                                  : tenant['status'] == 'Inactive'
                                      ? Colors.red.shade200
                                      : Colors.orange.shade200,
                            ),
                          ),
                          child: Text(
                            tenant['status'],
                            style: GoogleFonts.poppins(
                              color: tenant['status'] == 'Active' 
                                  ? Colors.green.shade800 
                                  : tenant['status'] == 'Inactive'
                                      ? Colors.red.shade800
                                      : Colors.orange.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Room ${tenant['room']} • ${tenant['pg']}',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${tenant['rent'].toStringAsFixed(0)}/month',
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showAddTenantDialog(context),
                  icon: const Icon(Icons.edit_outlined, size: 16, color: Colors.blue),
                  label: Text(
                    'Edit',
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: Colors.blue, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showComingSoon(context),
                  icon: const Icon(Icons.phone_outlined, size: 16, color: Colors.green),
                  label: Text(
                    'Call',
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: Colors.green, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showComingSoon(context),
                  icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.purple),
                  label: Text(
                    'Message',
                    style: GoogleFonts.poppins(
                      color: Colors.purple,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: Colors.purple, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                style: GoogleFonts.poppins(color: Colors.black), // Changed from white to black
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: GoogleFonts.poppins(color: Colors.black54), // Changed from white70 to black54
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
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
                style: GoogleFonts.poppins(color: Colors.black), // Changed from white to black
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: GoogleFonts.poppins(color: Colors.black54), // Changed from white70 to black54
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
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
                style: GoogleFonts.poppins(color: Colors.black), // Changed from white to black
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.poppins(color: Colors.black54), // Changed from white70 to black54
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
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
                      style: GoogleFonts.poppins(color: Colors.black), // Changed from white to black
                      decoration: InputDecoration(
                        labelText: 'Room Number',
                        labelStyle: GoogleFonts.poppins(color: Colors.black54), // Changed from white70 to black54
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
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
                      style: GoogleFonts.poppins(color: Colors.black), // Changed from white to black
                      decoration: InputDecoration(
                        labelText: 'Monthly Rent',
                        labelStyle: GoogleFonts.poppins(color: Colors.black54), // Changed from white70 to black54
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black26), // Changed from white30 to black26
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
              style: GoogleFonts.poppins(color: Colors.black54), // Changed from white70 to black54
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _tenants.add({
                    'name': _nameController.text,
                    'phone': _phoneController.text,
                    'email': _emailController.text,
                    'pg': _selectedPG,
                    'room': _roomController.text,
                    'rent': double.tryParse(_rentController.text) ?? 0.0,
                    'status': 'Active',
                    'joinDate': '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    'color': Colors.green,
                  });
                });
                
                _nameController.clear();
                _phoneController.clear();
                _emailController.clear();
                _roomController.clear();
                _rentController.clear();
                
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
                color: Colors.black, // Changed from white to black
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