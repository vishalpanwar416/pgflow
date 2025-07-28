import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';
  bool _showUnreadOnly = false;

  final List<String> _filters = ['All', 'Rent', 'Maintenance', 'Announcements', 'Emergency'];

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Rent Due Reminder',
      'message': 'Your rent of ₹5,500 is due on December 5th, 2024. Please ensure timely payment.',
      'type': 'Rent',
      'timestamp': '2024-12-01 10:30 AM',
      'isRead': false,
      'priority': 'high',
      'icon': Icons.payment,
      'color': Color(0xFFEF4444),
    },
    {
      'id': '2',
      'title': 'Maintenance Update',
      'message': 'Your AC maintenance request has been scheduled for December 3rd, 2024 at 2:00 PM.',
      'type': 'Maintenance',
      'timestamp': '2024-11-30 03:15 PM',
      'isRead': false,
      'priority': 'medium',
      'icon': Icons.build,
      'color': Color(0xFFF59E0B),
    },
    {
      'id': '3',
      'title': 'Water Supply Notice',
      'message': 'Water supply will be temporarily suspended on December 2nd from 10 AM to 2 PM for maintenance.',
      'type': 'Announcements',
      'timestamp': '2024-11-29 09:45 AM',
      'isRead': true,
      'priority': 'medium',
      'icon': Icons.water_drop,
      'color': Color(0xFF3B82F6),
    },
    {
      'id': '4',
      'title': 'Rent Payment Successful',
      'message': 'Your rent payment of ₹5,500 for November 2024 has been received. Thank you!',
      'type': 'Rent',
      'timestamp': '2024-11-03 11:20 AM',
      'isRead': true,
      'priority': 'low',
      'icon': Icons.check_circle,
      'color': Color(0xFF10B981),
    },
    {
      'id': '5',
      'title': 'Security Alert',
      'message': 'Please ensure all doors are locked and report any suspicious activity to security immediately.',
      'type': 'Emergency',
      'timestamp': '2024-11-28 08:30 PM',
      'isRead': true,
      'priority': 'high',
      'icon': Icons.security,
      'color': Color(0xFFDC2626),
    },
    {
      'id': '6',
      'title': 'New WiFi Password',
      'message': 'The WiFi password has been updated. New password: PG2024@wifi. Please update your devices.',
      'type': 'Announcements',
      'timestamp': '2024-11-27 02:00 PM',
      'isRead': true,
      'priority': 'medium',
      'icon': Icons.wifi,
      'color': Color(0xFF8B5CF6),
    },
    {
      'id': '7',
      'title': 'Complaint Resolved',
      'message': 'Your complaint about the leaking tap has been resolved. Please check and confirm.',
      'type': 'Maintenance',
      'timestamp': '2024-11-26 04:45 PM',
      'isRead': true,
      'priority': 'low',
      'icon': Icons.build,
      'color': Color(0xFF10B981),
    },
    {
      'id': '8',
      'title': 'Monthly Cleaning Schedule',
      'message': 'Monthly deep cleaning will be conducted on December 1st. Please keep your room accessible.',
      'type': 'Announcements',
      'timestamp': '2024-11-25 01:30 PM',
      'isRead': true,
      'priority': 'low',
      'icon': Icons.cleaning_services,
      'color': Color(0xFF06B6D4),
    },
  ];

  List<Map<String, dynamic>> get _filteredNotifications {
    return _notifications.where((notification) {
      final matchesFilter = _selectedFilter == 'All' || notification['type'] == _selectedFilter;
      final matchesReadStatus = !_showUnreadOnly || !notification['isRead'];
      return matchesFilter && matchesReadStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCard(),
          _buildFilterChips(),
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    final totalNotifications = _notifications.length;
    final unreadCount = _notifications.where((n) => !n['isRead']).length;
    final highPriorityCount = _notifications.where((n) => n['priority'] == 'high').length;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications Overview',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Last 30 days',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem('Total', totalNotifications.toString(), Colors.white),
              const SizedBox(width: 20),
              _buildStatItem('Unread', unreadCount.toString(), const Color(0xFFFFD700)),
              const SizedBox(width: 20),
              _buildStatItem('High Priority', highPriorityCount.toString(), const Color(0xFFFF6B6B)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length + 1, // +1 for unread filter
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
              child: FilterChip(
                label: Text(
                  _showUnreadOnly ? 'Unread Only' : 'All',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _showUnreadOnly ? Colors.white : const Color(0xFF6B7280),
                  ),
                ),
                selected: _showUnreadOnly,
                onSelected: (selected) {
                  setState(() => _showUnreadOnly = selected);
                },
                selectedColor: const Color(0xFFEF4444),
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: _showUnreadOnly ? const Color(0xFFEF4444) : const Color(0xFFE5E7EB),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }
          
          final filter = _filters[index - 1];
          final isSelected = _selectedFilter == filter;
          
          return Container(
            margin: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
            child: FilterChip(
              label: Text(
                filter,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter);
              },
              selectedColor: const Color(0xFF667EEA),
              backgroundColor: Colors.white,
              side: BorderSide(
                color: isSelected ? const Color(0xFF667EEA) : const Color(0xFFE5E7EB),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList() {
    if (_filteredNotifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredNotifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationCard(_filteredNotifications[index]);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification['isRead'] ? const Color(0xFFE5E7EB) : notification['color'].withOpacity(0.3),
          width: notification['isRead'] ? 1 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _markAsRead(notification['id']),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: notification['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: notification['isRead'] ? FontWeight.w600 : FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        if (!notification['isRead'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: notification['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification['message'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(notification['priority']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            notification['priority'].toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(notification['priority']),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: notification['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            notification['type'],
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: notification['color'],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          notification['timestamp'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color(0xFFEF4444);
      case 'medium':
        return const Color(0xFFF59E0B);
      case 'low':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Filter Notifications',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('All Notifications', 'All'),
            _buildFilterOption('Rent Related', 'Rent'),
            _buildFilterOption('Maintenance Updates', 'Maintenance'),
            _buildFilterOption('Announcements', 'Announcements'),
            _buildFilterOption('Emergency Alerts', 'Emergency'),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(
                'Show Unread Only',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _showUnreadOnly,
              onChanged: (value) {
                setState(() => _showUnreadOnly = value);
              },
              activeColor: const Color(0xFF667EEA),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Filters applied!'),
                  backgroundColor: const Color(0xFF667EEA),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Apply',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String title, String value) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),
      ),
      value: value,
      groupValue: _selectedFilter,
      onChanged: (newValue) {
        setState(() => _selectedFilter = newValue!);
      },
      activeColor: const Color(0xFF667EEA),
    );
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n['id'] == notificationId);
      notification['isRead'] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Marked as read'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
} 