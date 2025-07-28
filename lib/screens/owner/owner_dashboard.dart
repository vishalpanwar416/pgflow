import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/logout_helper.dart';
import 'subscription_management_screen.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> with TickerProviderStateMixin {
  AnimationController? _fadeController;
  AnimationController? _slideController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  String _selectedPG = 'All PGs';
  int _selectedPGIndex = 0;

  final List<String> _pgs = ['All PGs', 'PG Sunshine', 'PG Royal', 'PG Comfort', 'PG Elite'];

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Total Revenue',
      'value': '₹2,45,000',
      'subtitle': 'This month',
      'icon': Icons.trending_up,
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
      'trend': 'up',
      'percentage': '+12.5%',
    },
    {
      'title': 'Total Tenants',
      'value': '48',
      'subtitle': 'Across all PGs',
      'icon': Icons.people,
      'color': const Color(0xFF3B82F6),
      'bgColor': const Color(0xFFEFF6FF),
      'trend': 'up',
      'percentage': '+8.2%',
    },
    {
      'title': 'Occupancy Rate',
      'value': '92%',
      'subtitle': 'Average occupancy',
      'icon': Icons.home,
      'color': const Color(0xFFF59E0B),
      'bgColor': const Color(0xFFFFFBEB),
      'trend': 'neutral',
      'percentage': '0%',
    },
    {
      'title': 'Pending Rent',
      'value': '₹18,500',
      'subtitle': 'From 3 tenants',
      'icon': Icons.payment,
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEF2F2),
      'trend': 'down',
      'percentage': '-15.3%',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'title': 'PG Management',
      'subtitle': 'Manage properties',
      'icon': Icons.home_work,
      'route': '/owner/pg-management',
      'color': const Color(0xFF8B5CF6),
      'bgColor': const Color(0xFFF3E8FF),
    },
    {
      'title': 'Tenant Management',
      'subtitle': 'Manage tenants',
      'icon': Icons.people,
      'route': '/owner/tenant-management',
      'color': const Color(0xFF06B6D4),
      'bgColor': const Color(0xFFECFEFF),
    },
    {
      'title': 'Rent Collection',
      'subtitle': 'Track payments',
      'icon': Icons.payment,
      'route': '/owner/rent-collection',
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
    },
    {
      'title': 'Complaints',
      'subtitle': 'Handle issues',
      'icon': Icons.support_agent,
      'route': '/owner/complaints',
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEF2F2),
    },
    {
      'title': 'Notices',
      'subtitle': 'Manage notices',
      'icon': Icons.campaign,
      'route': '/owner/notices',
      'color': const Color(0xFFF59E0B),
      'bgColor': const Color(0xFFFFFBEB),
    },
    {
      'title': 'Broadcast',
      'subtitle': 'Send messages',
      'icon': Icons.broadcast_on_personal,
      'route': '/owner/broadcast',
      'color': const Color(0xFF667EEA),
      'bgColor': const Color(0xFFF0F9FF),
    },
    {
      'title': 'Subscriptions',
      'subtitle': 'Manage plans',
      'icon': Icons.subscriptions,
      'route': '/owner/subscriptions',
      'color': const Color(0xFFEC4899),
      'bgColor': const Color(0xFFFDF2F8),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

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
            _buildModernAppBar(),
            SliverToBoxAdapter(
              child: _fadeAnimation != null && _slideAnimation != null
                  ? FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom + 60, // Increased padding
                          ),
                          child: Column(
                            children: [
                              _buildWelcomeSection(),
                              _buildPGSelector(),
                              _buildStatsSection(),
                              _buildQuickActionsSection(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 60, // Increased padding
                      ),
                      child: Column(
                        children: [
                          _buildWelcomeSection(),
                          _buildPGSelector(),
                          _buildStatsSection(),
                          _buildQuickActionsSection(),
                        ],
                      ),
                    ),
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
                Color(0xFF1E293B),
                Color(0xFF334155),
              ],
            ),
          ),
        ),
        title: Text(
          'Owner Dashboard',
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
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
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
            color: const Color(0xFF1F2937).withOpacity(0.08),
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
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF334155)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E293B).withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.business,
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
                  'Good ${_getGreeting()}, Owner!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Welcome back to your PG empire',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                            '4 PGs Active',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6),
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
                            '48 Tenants',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPGSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select PG',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _pgs.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedPGIndex == index;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPGIndex = index;
                        _selectedPG = _pgs[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1E293B) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF1E293B) : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        _pgs[index],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Reduced vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: GoogleFonts.poppins(
              fontSize: 20, // Reduced font size
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12), // Reduced spacing
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10, // Reduced spacing
              mainAxisSpacing: 10, // Reduced spacing
              childAspectRatio: 1.6, // Increased aspect ratio (more compact)
            ),
            itemCount: _stats.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 400 + (index * 100)),
                curve: Curves.easeOutCubic,
                child: _buildModernStatCard(_stats[index], index),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatCard(Map<String, dynamic> stat, int index) {
    // Extract values with null safety
    final title = stat['title']?.toString() ?? '';
    final value = stat['value']?.toString() ?? '';
    final subtitle = stat['subtitle']?.toString() ?? '';
    final trend = stat['trend']?.toString() ?? 'neutral';
    final percentage = stat['percentage']?.toString() ?? '0%';
    final icon = stat['icon'] as IconData? ?? Icons.info;
    final color = stat['color'] as Color? ?? const Color(0xFF6B7280);
    final bgColor = stat['bgColor'] as Color? ?? const Color(0xFFF3F4F6);

    return Container(
      padding: const EdgeInsets.all(12), // Further reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Reduced radius
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.04),
            blurRadius: 12, // Reduced blur
            offset: const Offset(0, 2), // Reduced offset
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8), // Further reduced padding
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8), // Reduced radius
                ),
                child: Icon(
                  icon,
                  size: 18, // Further reduced size
                  color: color,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), // Further reduced padding
                decoration: BoxDecoration(
                  color: _getTrendColor(trend).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5), // Reduced radius
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getTrendIcon(trend),
                      size: 9, // Further reduced size
                      color: _getTrendColor(trend),
                    ),
                    const SizedBox(width: 2), // Reduced spacing
                    Text(
                      percentage,
                      style: GoogleFonts.poppins(
                        fontSize: 9, // Further reduced font size
                        fontWeight: FontWeight.w600,
                        color: _getTrendColor(trend),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Reduced spacing
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18, // Reduced font size
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 1), // Minimal spacing
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11, // Reduced font size
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 1), // Minimal spacing
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 9, // Reduced font size
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12, // Reduced spacing
              mainAxisSpacing: 12, // Reduced spacing
              childAspectRatio: 1.5, // Increased aspect ratio (more compact)
            ),
            itemCount: _quickActions.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 600 + (index * 100)),
                curve: Curves.easeOutCubic,
                child: _buildModernMenuCard(_quickActions[index]),
              );
            },
          ),
          const SizedBox(height: 50), // Increased bottom padding
        ],
      ),
    );
  }

  Widget _buildModernMenuCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _navigateToScreen(item['route']);
      },
      child: Container(
        padding: const EdgeInsets.all(12), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Reduced radius
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Reduced padding
              decoration: BoxDecoration(
                color: item['bgColor'],
                borderRadius: BorderRadius.circular(12), // Reduced radius
              ),
              child: Icon(
                item['icon'],
                size: 24, // Reduced size
                color: item['color'],
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            Text(
              item['title'],
              style: GoogleFonts.poppins(
                fontSize: 12, // Reduced font size
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2), // Reduced spacing
            Text(
              item['subtitle'],
              style: GoogleFonts.poppins(
                fontSize: 9, // Reduced font size
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

  void _navigateToScreen(String route) {
    switch (route) {
      case '/owner/subscriptions':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionManagementScreen()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigating to $route'),
            backgroundColor: const Color(0xFF667EEA),
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
        return const Color(0xFF10B981);
      case 'down':
        return const Color(0xFFEF4444);
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
        return Icons.remove;
    }
  }
} 