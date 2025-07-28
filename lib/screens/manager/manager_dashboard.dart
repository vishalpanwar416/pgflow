import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/pg_model.dart';
import '../../utils/logout_helper.dart';

class ManagerDashboard extends StatefulWidget {
  final PG assignedPG;

  const ManagerDashboard({super.key, required this.assignedPG});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> with TickerProviderStateMixin {
  AnimationController? _fadeController;
  AnimationController? _slideController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Total Tenants',
      'value': '12',
      'subtitle': 'In this PG',
      'icon': Icons.people,
      'color': const Color(0xFF3B82F6),
      'bgColor': const Color(0xFFEFF6FF),
      'trend': 'up',
      'percentage': '+2',
    },
    {
      'title': 'Rent Collected',
      'value': '₹66,000',
      'subtitle': 'This month',
      'icon': Icons.payment,
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
      'trend': 'up',
      'percentage': '+8.5%',
    },
    {
      'title': 'Occupancy Rate',
      'value': '100%',
      'subtitle': 'Full occupancy',
      'icon': Icons.home,
      'color': const Color(0xFFF59E0B),
      'bgColor': const Color(0xFFFFFBEB),
      'trend': 'neutral',
      'percentage': '0%',
    },
    {
      'title': 'Pending Issues',
      'value': '3',
      'subtitle': 'Complaints to resolve',
      'icon': Icons.support_agent,
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEF2F2),
      'trend': 'down',
      'percentage': '-25%',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'title': 'Tenant Management',
      'subtitle': 'Manage tenants',
      'icon': Icons.people,
      'route': '/manager/tenant-management',
      'color': const Color(0xFF06B6D4),
      'bgColor': const Color(0xFFECFEFF),
    },
    {
      'title': 'Rent Collection',
      'subtitle': 'Track payments',
      'icon': Icons.payment,
      'route': '/manager/rent-collection',
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
    },
    {
      'title': 'Complaints',
      'subtitle': 'Handle issues',
      'icon': Icons.support_agent,
      'route': '/manager/complaints',
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEF2F2),
    },
    {
      'title': 'Notices',
      'subtitle': 'Manage notices',
      'icon': Icons.campaign,
      'route': '/manager/notices',
      'color': const Color(0xFFF59E0B),
      'bgColor': const Color(0xFFFFFBEB),
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
                            bottom: MediaQuery.of(context).padding.bottom + 40,
                          ),
                          child: Column(
                            children: [
                              _buildWelcomeSection(),
                              _buildPGInfoCard(),
                              _buildStatsSection(),
                              _buildQuickActionsSection(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 40,
                      ),
                      child: Column(
                        children: [
                          _buildWelcomeSection(),
                          _buildPGInfoCard(),
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
      expandedHeight: 100,
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
                Color(0xFFF59E0B),
                Color(0xFFD97706),
              ],
            ),
          ),
        ),
        title: Text(
          'Manager Dashboard',
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF59E0B).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.manage_accounts,
              size: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good ${_getGreeting()}, Manager!',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Managing ${widget.assignedPG.pgName}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Active Manager',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.home_work_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assigned PG',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.assignedPG.pgName,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.assignedPG.address,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoChip(Icons.people_outline, 'Tenants', '${widget.assignedPG.occupiedRooms}/${widget.assignedPG.totalRooms}'),
              const SizedBox(width: 10),
              _buildInfoChip(Icons.home_outlined, 'Rooms', '${widget.assignedPG.totalRooms}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: Colors.white.withOpacity(0.8),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 11,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.9, // Increased from 1.6/1.7 to 1.9
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
    final title = stat['title']?.toString() ?? '';
    final value = stat['value']?.toString() ?? '';
    final subtitle = stat['subtitle']?.toString() ?? '';
    final trend = stat['trend']?.toString() ?? 'neutral';
    final percentage = stat['percentage']?.toString() ?? '0%';
    final icon = stat['icon'] as IconData? ?? Icons.info;
    final color = stat['color'] as Color? ?? const Color(0xFF6B7280);
    final bgColor = stat['bgColor'] as Color? ?? const Color(0xFFF3F4F6);

    return Container(
      padding: const EdgeInsets.all(8), // Even smaller padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: color,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: _getTrendColor(trend).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getTrendIcon(trend),
                      size: 8,
                      color: _getTrendColor(trend),
                    ),
                    const SizedBox(width: 1),
                    Text(
                      percentage,
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: _getTrendColor(trend),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 7,
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
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.7,
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
          const SizedBox(height: 30),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item['bgColor'],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                item['icon'],
                size: 20,
                color: item['color'],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['title'],
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              item['subtitle'],
              style: GoogleFonts.poppins(
                fontSize: 9,
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
    // Placeholder navigation - you can implement actual navigation here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $route'),
        backgroundColor: const Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
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
