import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'base_owner_screen.dart';
import '../../theme/owner_theme.dart';
import '../../widgets/owner/owner_card.dart';

class ComplaintsManagementScreen extends StatefulWidget {
  const ComplaintsManagementScreen({super.key});

  @override
  State<ComplaintsManagementScreen> createState() => _ComplaintsManagementScreenState();
}

class _ComplaintsManagementScreenState extends State<ComplaintsManagementScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _resolutionController = TextEditingController();
  late AnimationController _animationController;
  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  final List<String> _pgs = ['All PGs', 'Sunshine PG', 'Royal PG', 'Comfort PG'];
  final List<String> _statuses = ['All', 'Open', 'In Progress', 'Resolved'];
  final List<String> _priorities = ['All', 'Low', 'Medium', 'High', 'Urgent'];

  final List<Map<String, dynamic>> _complaints = [
    {
      'id': 'C001',
      'tenant': 'John Doe',
      'pg': 'Sunshine PG',
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
      'pg': 'Sunshine PG',
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
      'pg': 'Royal PG',
      'room': '201',
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
      'pg': 'Comfort PG',
      'room': '301',
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
    _resolutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalComplaints = _complaints.length;
    final openComplaints = _complaints.where((c) => c['status'] == 'Open').length;
    final inProgressComplaints = _complaints.where((c) => c['status'] == 'In Progress').length;
    final resolvedComplaints = _complaints.where((c) => c['status'] == 'Resolved').length;

    return BaseOwnerScreen(
      title: 'Complaints Management',
      actions: [
        IconButton(
          icon: const Icon(Icons.analytics, color: Color(0xFF667EEA)),
          onPressed: () => _showComingSoon(context),
          tooltip: 'Analytics',
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
                '$totalComplaints',
                Icons.support_agent_rounded,
                const Color(0xFF667EEA),
              ),
              _buildStatCard(
                'Open',
                '$openComplaints',
                Icons.fiber_new_rounded,
                const Color(0xFFEF4444),
              ),
              _buildStatCard(
                'In Progress',
                '$inProgressComplaints',
                Icons.pending_actions_rounded,
                const Color(0xFFF59E0B),
              ),
              _buildStatCard(
                'Resolved',
                '$resolvedComplaints',
                Icons.check_circle_rounded,
                const Color(0xFF10B981),
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
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
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedPriority,
                  dropdownColor: OwnerTheme.colorSurface,
                  iconEnabledColor: OwnerTheme.colorPrimary,
                  style: OwnerTheme.textStyleBody1,
                  decoration: OwnerTheme.inputDecoration(labelText: 'Priority'),
                  items: _priorities.map((priority) => DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  )).toList(),
                  onChanged: (value) => setState(() => _selectedPriority = value!),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Complaints List
          Text(
            'All Complaints',
            style: OwnerTheme.textStyleHeading3,
          ),
          const SizedBox(height: 16),
          ..._complaints.map((complaint) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildComplaintCard(complaint),
          )),
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

  Widget _buildComplaintCard(Map<String, dynamic> complaint) {
    return ModernCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
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
                        color: Colors.black, // Changed from white to black
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${complaint['tenant']} - ${complaint['pg']} Room ${complaint['room']}',
                      style: GoogleFonts.poppins(
                        color: Colors.black54, // Changed from white70 to black54
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
              const Spacer(),
              Text(
                complaint['createdAt'],
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
                    foregroundColor: Colors.black, // Changed from white to black
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
                    foregroundColor: Colors.black, // Changed from white to black
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
        color: color.withValues(alpha: 0.2),
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