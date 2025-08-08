import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../models/pg_model.dart';
import '../../utils/logout_helper.dart';
import 'tenant_management_screen.dart';
import 'rent_collection_screen.dart';
import 'complaints_management_screen.dart';
import 'notices_management_screen.dart';

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
      'screen': 'tenant_management',
      'color': const Color(0xFF06B6D4),
      'bgColor': const Color(0xFFECFEFF),
    },
    {
      'title': 'Rent Collection',
      'subtitle': 'Track payments',
      'icon': Icons.payment,
      'screen': 'rent_collection',
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
    },
    {
      'title': 'Complaints',
      'subtitle': 'Handle issues',
      'icon': Icons.support_agent,
      'screen': 'complaints_management',
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEF2F2),
    },
    {
      'title': 'Notices',
      'subtitle': 'Manage notices',
      'icon': Icons.campaign,
      'screen': 'notices_management',
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
            color: Colors.white.withValues(alpha: 0.2),
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
      height: 220,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF667EEA),
            Color(0xFF764BA2),
            Color(0xFF8B5CF6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.6, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withValues(alpha: 0.4),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: const Color(0xFF764BA2).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Enhanced background patterns
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ),
          // Floating geometric shapes
          Positioned(
            left: 30,
            top: 40,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            right: 80,
            top: 60,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with status indicator
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good ${_getGreeting()}, Manager!',
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Managing ${widget.assignedPG.pgName} efficiently',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white.withValues(alpha: 0.85),
                              height: 1.3,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Online',
                            style: GoogleFonts.inter(
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
                const SizedBox(height: 20),
                // Quick stats row
                Row(
                  children: [
                    _buildMiniStat('12', 'Tenants', Icons.people_rounded),
                    const SizedBox(width: 16),
                    _buildMiniStat('3', 'Issues', Icons.warning_rounded),
                    const SizedBox(width: 16),
                    _buildMiniStat('95%', 'Occupied', Icons.home_rounded),
                  ],
                ),
                const Spacer(),
                // Enhanced action buttons
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withValues(alpha: 0.95),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _navigateToScreen('tenant_management'),
                            borderRadius: BorderRadius.circular(18),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.people_rounded,
                                    size: 18,
                                    color: const Color(0xFF667EEA),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Manage Tenants',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: const Color(0xFF667EEA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Quick action buttons
                    _buildQuickActionButton(
                      Icons.support_agent_rounded,
                      'Complaints',
                      () => _navigateToScreen('complaints_management'),
                    ),
                    const SizedBox(width: 8),
                    _buildQuickActionButton(
                      Icons.payment_rounded,
                      'Rent',
                      () => _navigateToScreen('rent_collection'),
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

  Widget _buildMiniStat(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
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
              size: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.7),
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String tooltip, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
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
            color: const Color(0xFF1E293B).withValues(alpha: 0.2),
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
                  color: Colors.white.withValues(alpha: 0.1),
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
                        color: Colors.white.withValues(alpha: 0.7),
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
                    color: Colors.white.withValues(alpha: 0.8),
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
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
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
            size: 13,
            color: Colors.white.withValues(alpha: 0.8),
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
                  color: Colors.white.withValues(alpha: 0.7),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Overview',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Live Data',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Real-time insights for ${widget.assignedPG.pgName}',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: _stats.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 600 + (index * 150)),
                curve: Curves.easeOutCubic,
                child: _buildEnhancedStatCard(_stats[index], index),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatCard(Map<String, dynamic> stat, int index) {
    final title = stat['title']?.toString() ?? '';
    final value = stat['value']?.toString() ?? '';
    final subtitle = stat['subtitle']?.toString() ?? '';
    final trend = stat['trend']?.toString() ?? 'neutral';
    final percentage = stat['percentage']?.toString() ?? '0%';
    final icon = stat['icon'] as IconData? ?? Icons.info;
    final color = stat['color'] as Color? ?? const Color(0xFF6B7280);
    final bgColor = stat['bgColor'] as Color? ?? const Color(0xFFF3F4F6);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const Spacer(),
                if (trend != 'neutral')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: _getTrendColor(trend).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getTrendColor(trend).withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getTrendIcon(trend),
                          size: 10,
                          color: _getTrendColor(trend),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          percentage,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getTrendColor(trend),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // Progress indicator for visual enhancement
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _getProgressValue(title),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withValues(alpha: 0.8), color],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getProgressValue(String title) {
    // Return different progress values based on stat type for visual variety
    switch (title) {
      case 'Total Tenants':
        return 0.8; // 80% filled
      case 'Rent Collected':
        return 0.95; // 95% filled
      case 'Occupancy Rate':
        return 1.0; // 100% filled
      case 'Pending Issues':
        return 0.3; // 30% filled (lower is better for issues)
      default:
        return 0.7;
    }
  }

  Widget _buildQuickActionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
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
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: _quickActions.length,
            itemBuilder: (context, index) {
              final action = _quickActions[index];
              return _buildModernMenuCard(action);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModernMenuCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _navigateToScreen(item['screen']);
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
              color: const Color(0xFF1F2937).withValues(alpha: 0.04),
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

  void _navigateToScreen(String screenName) {
    try {
      switch (screenName) {
        case 'tenant_management':
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ManagerTenantManagementScreen(assignedPG: widget.assignedPG.pgName),
            ),
          );
          break;
        case 'rent_collection':
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ManagerRentCollectionScreen(assignedPG: widget.assignedPG.pgName),
            ),
          );
          break;
        case 'complaints_management':
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ManagerComplaintsManagementScreen(assignedPG: widget.assignedPG.pgName),
            ),
          );
          break;
        case 'notices_management':
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ManagerNoticesManagementScreen(assignedPG: widget.assignedPG.pgName),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Screen not available: $screenName'),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error navigating to screen: ${e.toString()}'),
          backgroundColor: const Color(0xFFEF4444),
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
