import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_owner_screen.dart';

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  late AnimationController _animationController;
  String _selectedPG = 'All PGs';
  String _selectedType = 'General';
  String _selectedPriority = 'Normal';

  final List<String> _pgs = ['All PGs', 'Sunshine PG', 'Royal PG', 'Comfort PG'];
  final List<String> _types = ['General', 'Maintenance', 'Emergency', 'Payment', 'Event'];
  final List<String> _priorities = ['Low', 'Normal', 'High', 'Urgent'];

  final List<Map<String, dynamic>> _broadcasts = [
    {
      'id': 'B001',
      'title': 'Maintenance Notice',
      'type': 'Maintenance',
      'priority': 'High',
      'message': 'Water supply will be interrupted tomorrow from 10 AM to 2 PM for maintenance work. Please store water accordingly.',
      'pg': 'All PGs',
      'sentDate': '2 hours ago',
      'recipients': 45,
      'readCount': 38,
      'color': Colors.orange,
    },
    {
      'id': 'B002',
      'title': 'Security Update',
      'type': 'General',
      'priority': 'Normal',
      'message': 'New security cameras have been installed. Please ensure all doors are locked properly.',
      'pg': 'Sunshine PG',
      'sentDate': '1 day ago',
      'recipients': 18,
      'readCount': 15,
      'color': Colors.blue,
    },
    {
      'id': 'B003',
      'title': 'Rent Due Reminder',
      'type': 'Payment',
      'priority': 'High',
      'message': 'Friendly reminder: Rent is due on 15th December. Please ensure timely payment.',
      'pg': 'All PGs',
      'sentDate': '2 days ago',
      'recipients': 45,
      'readCount': 42,
      'color': Colors.red,
    },
    {
      'id': 'B004',
      'title': 'New Year Celebration',
      'type': 'Event',
      'priority': 'Low',
      'message': 'Join us for New Year celebration in the common area. Food and refreshments will be provided.',
      'pg': 'All PGs',
      'sentDate': '3 days ago',
      'recipients': 45,
      'readCount': 40,
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
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalBroadcasts = _broadcasts.length;
    final totalRecipients = _broadcasts.fold<int>(0, (sum, b) => sum + (b['recipients'] as int));
    final totalRead = _broadcasts.fold<int>(0, (sum, b) => sum + (b['readCount'] as int));
    final readRate = totalRecipients > 0 ? ((totalRead / totalRecipients) * 100).toStringAsFixed(1) : '0';

    return BaseOwnerScreen(
      title: 'Broadcast Messages',
      actions: [
        IconButton(
          icon: const Icon(Icons.analytics, color: Color(0xFF667EEA)),
          onPressed: () => _showComingSoon(context),
          tooltip: 'Analytics',
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBroadcastDialog(context),
        backgroundColor: const Color(0xFF667EEA),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text(
          'New Broadcast',
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
                'Total',
                '$totalBroadcasts',
                Icons.broadcast_on_home_rounded,
                const Color(0xFF667EEA),
              ),
              _buildStatCard(
                'Recipients',
                '$totalRecipients',
                Icons.people_rounded,
                const Color(0xFF3B82F6),
              ),
              _buildStatCard(
                'Read',
                '$totalRead',
                Icons.visibility_rounded,
                const Color(0xFF10B981),
              ),
              _buildStatCard(
                'Read Rate',
                '$readRate%',
                Icons.analytics_rounded,
                const Color(0xFFF59E0B),
              ),
            ],
          ),
          
          // Send New Broadcast
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
                Row(
                  children: [
                    Icon(Icons.broadcast_on_personal, color: Colors.orange, size: 24),
                    const SizedBox(width: 12.0),
                    Text(
                      'Send New Broadcast',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Title',
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
                            child: DropdownButtonFormField<String>(
                              value: _selectedPG,
                              dropdownColor: Colors.black,
                              iconEnabledColor: Colors.orange,
                              style: GoogleFonts.poppins(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Target PG',
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
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _messageController,
                        maxLines: 4,
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Message',
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Broadcast sent successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _titleController.clear();
                              _messageController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Send Broadcast',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28.0),
          // Broadcast History
          Text(
            'Broadcast History',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          ..._broadcasts.map((broadcast) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildBroadcastCard(broadcast),
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

  Widget _buildBroadcastCard(Map<String, dynamic> broadcast) {
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
                  color: broadcast['color'].withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.broadcast_on_personal,
                  color: broadcast['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      broadcast['title'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      broadcast['pg'],
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _buildChip(broadcast['priority'], _getPriorityColor(broadcast['priority'])),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            broadcast['message'],
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              _buildChip(broadcast['type'], Colors.blue),
              const SizedBox(width: 8.0),
              _buildChip('${broadcast['readCount']}/${broadcast['recipients']} Read', Colors.green),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Text(
                broadcast['sentDate'],
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                'ID: ${broadcast['id']}',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Low':
        return Colors.green;
      case 'Normal':
        return Colors.blue;
      case 'High':
        return Colors.orange;
      case 'Urgent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAddBroadcastDialog(BuildContext context) {
    // Implement your dialog here
    _showComingSoon(context); // Temporary solution using existing method
  }
}