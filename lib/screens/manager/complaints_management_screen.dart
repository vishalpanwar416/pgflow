import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerComplaintsManagementScreen extends StatefulWidget {
  final String assignedPG;
  
  const ManagerComplaintsManagementScreen({super.key, required this.assignedPG});

  @override
  State<ManagerComplaintsManagementScreen> createState() => _ManagerComplaintsManagementScreenState();
}

class _ManagerComplaintsManagementScreenState extends State<ManagerComplaintsManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _resolutionController = TextEditingController();
  String _selectedStatus = 'All';
  String _selectedPriority = 'All';

  final List<String> _statuses = ['All', 'Open', 'In Progress', 'Resolved'];
  final List<String> _priorities = ['All', 'Low', 'Medium', 'High', 'Urgent'];

  final List<Map<String, dynamic>> _complaints = [
    {
      'id': 'C001',
      'tenant': 'John Doe',
      'room': '101',
      'issue': 'Water Leak in Bathroom',
      'category': 'Maintenance',
      'priority': 'High',
      'status': 'Open',
      'description': 'There is a water leak from the bathroom ceiling. Need immediate attention.',
      'createdAt': '2 days ago',
      'color': Colors.red,
    },
    {
      'id': 'C002',
      'tenant': 'Jane Smith',
      'room': '102',
      'issue': 'AC Not Working',
      'category': 'Electrical',
      'priority': 'Urgent',
      'status': 'In Progress',
      'description': 'Air conditioner stopped working. Room is very hot.',
      'createdAt': '1 day ago',
      'color': Colors.orange,
    },
    {
      'id': 'C003',
      'tenant': 'Mike Johnson',
      'room': '103',
      'issue': 'Cleaning Request',
      'category': 'Cleaning',
      'priority': 'Low',
      'status': 'Resolved',
      'description': 'Request for room cleaning service.',
      'createdAt': '3 days ago',
      'color': Colors.green,
    },
    {
      'id': 'C004',
      'tenant': 'Sarah Wilson',
      'room': '104',
      'issue': 'Broken Window',
      'category': 'Maintenance',
      'priority': 'Medium',
      'status': 'Resolved',
      'description': 'Window glass is broken and needs replacement.',
      'createdAt': '1 week ago',
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalComplaints = _complaints.length;
    final openComplaints = _complaints.where((c) => c['status'] == 'Open').length;
    final inProgressComplaints = _complaints.where((c) => c['status'] == 'In Progress').length;
    final resolvedComplaints = _complaints.where((c) => c['status'] == 'Resolved').length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Complaints Management',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics, color: Colors.orange),
            onPressed: () => _showComingSoon(context),
            tooltip: 'Analytics',
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
                          'Complaints Management',
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
                  child: _buildStatCard('Total', '$totalComplaints', Icons.list_alt, Colors.blue),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Open', '$openComplaints', Icons.pending_actions, Colors.red),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('In Progress', '$inProgressComplaints', Icons.engineering, Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Resolved', '$resolvedComplaints', Icons.check_circle, Colors.green),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Avg Resolution', '2.5 days', Icons.timer, Colors.purple),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatCard('Satisfaction', '4.2/5', Icons.star, Colors.yellow),
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
                    color: Colors.orange.withOpacity(0.08),
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
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedPriority,
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.orange,
                          style: GoogleFonts.poppins(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Priority',
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
                          items: _priorities.map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          )).toList(),
                          onChanged: (value) => setState(() => _selectedPriority = value!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),
            // Complaints List
            Text(
              'All Complaints',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            ..._complaints.map((complaint) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildComplaintCard(complaint),
            )),
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
            color: Colors.orange.withOpacity(0.08),
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

  Widget _buildComplaintCard(Map<String, dynamic> complaint) {
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
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.report_problem,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      complaint['issue'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${complaint['tenant']} - Room ${complaint['room']}',
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
                  color: complaint['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  complaint['status'],
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
          Text(
            complaint['description'],
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              _buildChip(complaint['category'], Colors.blue),
              const SizedBox(width: 8.0),
              _buildChip(complaint['priority'], Colors.red),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Text(
                complaint['createdAt'],
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                'ID: ${complaint['id']}',
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
                  onPressed: () => _showResolutionDialog(context, complaint),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Add Resolution',
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

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  void _showResolutionDialog(BuildContext context, Map<String, dynamic> complaint) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Add Resolution',
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
              Text(
                'Complaint: ${complaint['issue']}',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _resolutionController,
                maxLines: 4,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Resolution Details',
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
                    content: Text('Resolution added successfully!'),
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
              'Add Resolution',
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