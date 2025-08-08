import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/logout_helper.dart';
import '../tenant/profile_screen.dart';
import '../tenant/rent_screen.dart';
import '../tenant/complaints_screen.dart';
import '../tenant/notices_screen.dart';
import '../tenant/emergency_screen.dart';
import 'maintenance_screen.dart';
import 'bill_management_screen.dart';
import 'notifications_screen.dart';

class TenantDashboard extends StatefulWidget {
  const TenantDashboard({super.key});

  @override
  State<TenantDashboard> createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard>
    with TickerProviderStateMixin {
  AnimationController? _fadeController;
  AnimationController? _slideController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Rent Due',
      'value': '₹5,500',
      'subtitle': 'Due in 5 days',
      'icon': Icons.payment_outlined,
      'color': const Color(0xFF6366F1),
      'bgColor': const Color(0xFFF0F9FF),
      'trend': 'up',
      'percentage': '+2.5%',
    },
    {
      'title': 'Days Left',
      'value': '25',
      'subtitle': 'In current month',
      'icon': Icons.calendar_today_outlined,
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
      'trend': 'neutral',
      'percentage': '0%',
    },
    {
      'title': 'Complaints',
      'value': '2',
      'subtitle': 'Pending resolution',
      'icon': Icons.report_problem_outlined,
      'color': const Color(0xFFF59E0B),
      'bgColor': const Color(0xFFFFFBEB),
      'trend': 'down',
      'percentage': '-50%',
    },
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'My Profile',
      'subtitle': 'View & edit profile',
      'icon': Icons.person_outline_rounded,
      'route': '/tenant/profile',
      'color': const Color(0xFF8B5CF6),
      'bgColor': const Color(0xFFF3E8FF),
    },
    {
      'title': 'Payments',
      'subtitle': 'Rent & utility bills',
      'icon': Icons.credit_card_outlined,
      'route': '/tenant/rent',
      'color': const Color(0xFF06B6D4),
      'bgColor': const Color(0xFFECFEFF),
    },
    {
      'title': 'Complaints',
      'subtitle': 'Report & track issues',
      'icon': Icons.support_agent_outlined,
      'route': '/tenant/complaints',
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEF2F2),
    },
    {
      'title': 'Notices',
      'subtitle': 'Important announcements',
      'icon': Icons.campaign_outlined,
      'route': '/tenant/notices',
      'color': const Color(0xFFF59E0B),
      'bgColor': const Color(0xFFFFFBEB),
    },
    {
      'title': 'Emergency',
      'subtitle': 'Quick emergency contacts',
      'icon': Icons.emergency_outlined,
      'route': '/tenant/emergency',
      'color': const Color(0xFFDC2626),
      'bgColor': const Color(0xFFFEF2F2),
    },
    {
      'title': 'Maintenance',
      'subtitle': 'Request & Track',
      'icon': Icons.build,
      'route': '/tenant/maintenance',
      'color': const Color(0xFF4F46E5),
      'bgColor': const Color(0xFFF3E8FF),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController!,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController!,
      curve: Curves.easeOutCubic,
    ));

    // Start animations after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fadeController?.forward();
        _slideController?.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    _slideController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _fadeAnimation != null && _slideAnimation != null
                  ? FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildWelcomeSection(),
                              const SizedBox(height: 24),
                              _buildPGInfoCard(),
                              const SizedBox(height: 32),
                              _buildStatsSection(),
                              const SizedBox(height: 32),
                              _buildQuickActionsSection(),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1F2937),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
          ),
        ),
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () => performLogout(context),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good ${_getGreeting()}!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'John Doe',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Active',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPGInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.home_work_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Residence',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PG Sunshine',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Room A-101 • 123 Sunshine Street, City',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildInfoChip(Icons.payments_outlined, 'Rent', '₹5,500/month'),
              const SizedBox(width: 16),
              _buildInfoChip(Icons.date_range_outlined, 'Since', 'Jan 2024'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _stats.length,
          itemBuilder: (context, index) {
            final stat = _stats[index];
            return _buildModernStatCard(stat, index);
          },
        ),
      ],
    );
  }

  Widget _buildModernStatCard(Map<String, dynamic> stat, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: stat['bgColor'],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              stat['icon'],
              size: 28,
              color: stat['color'],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      stat['value'],
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTrendColor(stat['trend']).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getTrendIcon(stat['trend']),
                            size: 12,
                            color: _getTrendColor(stat['trend']),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            stat['percentage'] ?? '0%',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _getTrendColor(stat['trend']),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  stat['subtitle'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: _menuItems.length,
          itemBuilder: (context, index) {
            final action = _menuItems[index];
            return _buildModernMenuCard(action);
          },
        ),
      ],
    );
  }

  Widget _buildModernMenuCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _navigateToScreen(item['route']);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item['bgColor'],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                item['icon'],
                size: 28,
                color: item['color'],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item['title'],
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              item['subtitle'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Add this new method for navigation
  void _navigateToScreen(String route) {
    switch (route) {
      case '/tenant/profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      case '/tenant/rent':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RentScreen()),
        );
        break;
      case '/tenant/bills':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BillManagementScreen()),
        );
        break;
      case '/tenant/complaints':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ComplaintsScreen()),
        );
        break;
      case '/tenant/notices':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoticesScreen()),
        );
        break;
      case '/tenant/emergency':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmergencyScreen()),
        );
        break;
      case '/tenant/maintenance':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MaintenanceScreen()),
        );
        break;
      case '/tenant/notifications':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Screen not found: $route'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case 'up':
        return const Color(0xFFEF4444);
      case 'down':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case 'up':
        return Icons.trending_up_rounded;
      case 'down':
        return Icons.trending_down_rounded;
      default:
        return Icons.remove; // Using a different icon for neutral trend
    }
  }
}