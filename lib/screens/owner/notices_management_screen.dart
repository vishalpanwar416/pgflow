import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_owner_screen.dart';

class NoticesManagementScreen extends StatefulWidget {
  const NoticesManagementScreen({super.key});

  @override
  State<NoticesManagementScreen> createState() => _NoticesManagementScreenState();
}

class _NoticesManagementScreenState extends State<NoticesManagementScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _responseController = TextEditingController();
  late AnimationController _animationController;
  String _selectedPG = 'All PGs';
  String _selectedStatus = 'All';
  String _selectedType = 'All';

  final List<String> _pgs = ['All PGs', 'Sunshine PG', 'Royal PG', 'Comfort PG'];
  final List<String> _statuses = ['All', 'Pending', 'Approved', 'Rejected'];
  final List<String> _types = ['All', 'Vacate', 'Maintenance', 'General'];

  final List<Map<String, dynamic>> _notices = [
    {
      'id': 'N001',
      'tenant': 'John Doe',
      'pg': 'Sunshine PG',
      'room': '101',
      'type': 'Vacate',
      'reason': 'Job Transfer',
      'status': 'Pending',
      'details': 'Need to vacate due to job transfer to another city.',
      'submittedDate': '2 days ago',
      'effectiveDate': '15/01/2025',
      'color': Colors.orange,
    },
    {
      'id': 'N002',
      'tenant': 'Jane Smith',
      'pg': 'Sunshine PG',
      'room': '102',
      'type': 'Vacate',
      'reason': 'Personal',
      'status': 'Approved',
      'details': 'Personal reasons for vacating the room.',
      'submittedDate': '1 week ago',
      'effectiveDate': '01/01/2025',
      'color': Colors.green,
    },
    {
      'id': 'N003',
      'tenant': 'Mike Johnson',
      'pg': 'Royal PG',
      'room': '201',
      'type': 'Maintenance',
      'reason': 'Room Maintenance',
      'status': 'Approved',
      'details': 'Request for room maintenance and painting.',
      'submittedDate': '3 days ago',
      'effectiveDate': '20/12/2024',
      'color': Colors.green,
    },
    {
      'id': 'N004',
      'tenant': 'Sarah Wilson',
      'pg': 'Comfort PG',
      'room': '301',
      'type': 'General',
      'reason': 'Family Emergency',
      'status': 'Rejected',
      'details': 'Need to vacate due to family emergency.',
      'submittedDate': '5 days ago',
      'effectiveDate': '10/12/2024',
      'color': Colors.red,
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
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalNotices = _notices.length;
    final pendingNotices = _notices.where((n) => n['status'] == 'Pending').length;
    final approvedNotices = _notices.where((n) => n['status'] == 'Approved').length;
    final rejectedNotices = _notices.where((n) => n['status'] == 'Rejected').length;

    return BaseOwnerScreen(
      title: 'Notices Management',
      actions: [
        IconButton(
          icon: const Icon(Icons.broadcast_on_personal, color: Color(0xFF667EEA)),
          onPressed: () => _showComingSoon(context),
          tooltip: 'Broadcast',
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
                '$totalNotices',
                Icons.notifications_rounded,
                const Color(0xFF667EEA),
              ),
              _buildStatCard(
                'Pending',
                '$pendingNotices',
                Icons.pending_rounded,
                const Color(0xFFF59E0B),
              ),
              _buildStatCard(
                'Approved',
                '$approvedNotices',
                Icons.check_circle_rounded,
                const Color(0xFF10B981),
              ),
              _buildStatCard(
                'Rejected',
                '$rejectedNotices',
                Icons.cancel_rounded,
                const Color(0xFFEF4444),
              ),
            ],
          ),
          
          // Summary Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total', '$totalNotices', Icons.list_alt, Colors.blue),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildStatCard('Pending', '$pendingNotices', Icons.pending_actions, Colors.orange),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildStatCard('Approved', '$approvedNotices', Icons.check_circle, Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Rejected', '$rejectedNotices', Icons.cancel, Colors.red),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildStatCard('Avg Response', '1.2 days', Icons.timer, Colors.purple),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildStatCard('This Month', '8', Icons.calendar_month, Colors.teal),
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
                        value: _selectedPG,
                        dropdownColor: Colors.black,
                        iconEnabledColor: Colors.orange,
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'PG',
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
                        items: _pgs.map((pg) => DropdownMenuItem(
                          value: pg,
                          child: Text(pg),
                        )).toList(),
                        onChanged: (value) => setState(() => _selectedPG = value!),
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
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  dropdownColor: Colors.black,
                  iconEnabledColor: Colors.orange,
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Type',
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
                  items: _types.map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  )).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28.0),
          // Notices List
          Text(
            'All Notices',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          ..._notices.map((notice) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildNoticeCard(notice),
          )),
        ],
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

  Widget _buildNoticeCard(Map<String, dynamic> notice) {
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
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.notifications_active,
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
                      '${notice['type']} Notice',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${notice['tenant']} - ${notice['pg']} Room ${notice['room']}',
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
                  color: notice['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  notice['status'],
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
            notice['details'],
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              _buildChip(notice['reason'], Colors.blue),
              const SizedBox(width: 8.0),
              _buildChip('Effective: ${notice['effectiveDate']}', Colors.purple),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Text(
                'Submitted: ${notice['submittedDate']}',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                'ID: ${notice['id']}',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (notice['status'] == 'Pending')
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showResponseDialog(context, notice, 'Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Approve',
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
                      onPressed: () => _showResponseDialog(context, notice, 'Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Reject',
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

  void _showResponseDialog(BuildContext context, Map<String, dynamic> notice, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          '$action Notice',
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
                'Notice: ${notice['type']} Notice from ${notice['tenant']}',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _responseController,
                maxLines: 3,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Response/Comments',
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
                  SnackBar(
                    content: Text('Notice $action.toLowerCase() successfully!'),
                    backgroundColor: action == 'Approve' ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'Approve' ? Colors.green : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              action,
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