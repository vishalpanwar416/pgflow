import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Total Revenue',
      'value': '₹2,45,000',
      'subtitle': 'This month',
      'icon': Icons.trending_up_rounded,
      'color': const Color(0xFF10B981),
      'trend': true,
      'trendText': '+12.5%',
    },
    {
      'title': 'Total Tenants',
      'value': '48',
      'subtitle': 'Across all PGs',
      'icon': Icons.people_rounded,
      'color': const Color(0xFF3B82F6),
      'trend': true,
      'trendText': '+8.2%',
    },
    {
      'title': 'Occupancy Rate',
      'value': '92%',
      'subtitle': 'Average occupancy',
      'icon': Icons.home_rounded,
      'color': const Color(0xFFF59E0B),
      'trend': null,
      'trendText': '0%',
    },
    {
      'title': 'Pending Rent',
      'value': '₹18,500',
      'subtitle': 'From 3 tenants',
      'icon': Icons.payment_rounded,
      'color': const Color(0xFFEF4444),
      'trend': false,
      'trendText': '-15.3%',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'title': 'PG Management',
      'subtitle': 'Manage properties',
      'icon': Icons.home_work_rounded,
      'route': '/owner/dashboard/pg-management',
      'color': const Color(0xFF667EEA),
      'bgColor': const Color(0xFF667EEA).withValues(alpha: 0.1),
    },
    {
      'title': 'Tenant Management',
      'subtitle': 'Manage tenants',
      'icon': Icons.people_rounded,
      'route': '/owner/dashboard/tenant-management',
      'color': const Color(0xFF3B82F6),
      'bgColor': const Color(0xFF3B82F6).withValues(alpha: 0.1),
    },
    {
      'title': 'Rent Collection',
      'subtitle': 'Track payments',
      'icon': Icons.payment_rounded,
      'route': '/owner/dashboard/rent-collection',
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFF10B981).withValues(alpha: 0.1),
    },
    {
      'title': 'Complaints',
      'subtitle': 'Handle issues',
      'icon': Icons.support_agent_rounded,
      'route': '/owner/dashboard/complaints',
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFEF4444).withValues(alpha: 0.1),
    },
    {
      'title': 'Notices',
      'subtitle': 'Post updates',
      'icon': Icons.notifications_rounded,
      'route': '/owner/dashboard/notices',
      'color': const Color(0xFF8B5CF6),
      'bgColor': const Color(0xFF8B5CF6).withValues(alpha: 0.1),
    },
    {
      'title': 'Broadcast',
      'subtitle': 'Send messages',
      'icon': Icons.broadcast_on_home_rounded,
      'route': '/owner/dashboard/broadcast',
      'color': const Color(0xFFEC4899),
      'bgColor': const Color(0xFFEC4899).withValues(alpha: 0.1),
    },
    {
      'title': 'Subscription',
      'subtitle': 'Manage plan',
      'icon': Icons.credit_card_rounded,
      'route': '/owner/dashboard/subscription',
      'color': const Color(0xFF6366F1),
      'bgColor': const Color(0xFF6366F1).withValues(alpha: 0.1),
    },
  ];

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });

    _refreshData();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
              ),
            )
          : RefreshIndicator(
              onRefresh: _refreshData,
              color: const Color(0xFF667EEA),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeCard().animate()
                        .fadeIn(duration: 600.ms, delay: 100.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 24),
                    _buildStatsSection().animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 32),
                    _buildQuickActionsSection().animate()
                        .fadeIn(duration: 600.ms, delay: 300.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 32),
                    _buildRecentActivitySection().animate()
                        .fadeIn(duration: 600.ms, delay: 400.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 32),
                    _buildUpcomingPaymentsSection().animate()
                        .fadeIn(duration: 600.ms, delay: 500.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showQuickActionDialog(context),
        backgroundColor: const Color(0xFF667EEA),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: const Text(
          'Quick Action',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        icon: const Icon(Icons.add_rounded, size: 20),
      ).animate()
          .fadeIn(duration: 800.ms, delay: 600.ms)
          .scale(begin: const Offset(0.8, 0.8)),
    );
  }

  PreferredSizeWidget _buildAppBar(dynamic user, ThemeData theme) {
    return AppBar(
      title: Text(
        'Dashboard',
        style: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1E293B),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => _showUserMenu(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user?.displayName?.substring(0, 1).toUpperCase() ?? 'O',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user?.displayName ?? 'Owner',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        'Good ${_getGreeting()}!',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  Widget _buildWelcomeCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Here\'s what\'s happening with your properties today.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _navigateToAnalytics(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF667EEA),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.analytics_rounded, size: 18),
                  label: Text(
                    'View Analytics',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
            return _buildStatCard(stat, index);
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (stat['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    stat['icon'],
                    color: stat['color'],
                    size: 20,
                  ),
                ),
                const Spacer(),
                if (stat['trend'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: stat['trend'] == true
                          ? const Color(0xFF10B981).withValues(alpha: 0.1)
                          : const Color(0xFFEF4444).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          stat['trend'] == true
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          size: 12,
                          color: stat['trend'] == true
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          stat['trendText'],
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: stat['trend'] == true
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              stat['value'],
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['title'],
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              stat['subtitle'],
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
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
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _quickActions.length,
          itemBuilder: (context, index) {
            final action = _quickActions[index];
            return _buildActionCard(action, index);
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(Map<String, dynamic> action, int index) {
    return GestureDetector(
      onTap: () => _navigateToScreen(action['route']),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (action['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  action['icon'],
                  size: 28,
                  color: action['color'],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                action['title'],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                action['subtitle'],
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0)
        .scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildRecentActivitySection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Recent Activity',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _viewAllActivity(),
                  child: Text(
                    'View All',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF667EEA),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              icon: Icons.payment_rounded,
              title: 'Rent Received',
              subtitle: '₹15,000 from John Doe',
              time: '2 hours ago',
              color: const Color(0xFF10B981),
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              icon: Icons.support_agent_rounded,
              title: 'New Complaint',
              subtitle: 'Water leakage in room 203',
              time: '5 hours ago',
              color: const Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              icon: Icons.build_rounded,
              title: 'Maintenance Update',
              subtitle: 'Generator service completed',
              time: 'Yesterday',
              color: const Color(0xFF3B82F6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingPaymentsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Upcoming Payments',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _viewAllPayments(),
                  child: Text(
                    'View All',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF667EEA),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Rent due in the next 7 days',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
            _buildPaymentItem(
              name: 'Sarah Johnson',
              room: 'Room 105',
              amount: '₹12,000',
              dueIn: 'Tomorrow',
              isOverdue: false,
            ),
            const SizedBox(height: 16),
            _buildPaymentItem(
              name: 'Mike Wilson',
              room: 'Room 208',
              amount: '₹11,500',
              dueIn: 'In 3 days',
              isOverdue: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentItem({
    required String name,
    required String room,
    required String amount,
    required String dueIn,
    bool isOverdue = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOverdue 
            ? const Color(0xFFEF4444).withValues(alpha: 0.05)
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOverdue 
              ? const Color(0xFFEF4444).withValues(alpha: 0.2)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.substring(0, 1),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  room,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isOverdue ? const Color(0xFFEF4444) : const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dueIn,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                  color: isOverdue 
                      ? const Color(0xFFEF4444) 
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(String route) {
    // Close any open dialogs or bottom sheets first
    Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
    
    // Use GoRouter to navigate to the specified route
    context.go(route);
    
    // Show a snackbar to indicate navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $route'),
        backgroundColor: const Color(0xFF667EEA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _navigateToAnalytics() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening Analytics Dashboard...'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _viewAllActivity() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening Activity Log...'),
        backgroundColor: const Color(0xFF3B82F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _viewAllPayments() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening Payment History...'),
        backgroundColor: const Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person_rounded, color: Color(0xFF667EEA)),
              title: Text(
                'Profile Settings',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded, color: Color(0xFF667EEA)),
              title: Text(
                'App Settings',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help_rounded, color: Color(0xFF667EEA)),
              title: Text(
                'Help & Support',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Color(0xFFEF4444)),
              title: Text(
                'Logout',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFEF4444),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog(context);
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showQuickActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Quick Actions',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildQuickActionButton(
              icon: Icons.add_home_rounded,
              title: 'Add New PG',
              color: const Color(0xFF667EEA),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            _buildQuickActionButton(
              icon: Icons.person_add_rounded,
              title: 'Add New Tenant',
              color: const Color(0xFF10B981),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            _buildQuickActionButton(
              icon: Icons.notification_add_rounded,
              title: 'Send Notice',
              color: const Color(0xFFF59E0B),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Logout',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.inter(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }
}