import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionManagementScreen extends StatefulWidget {
  const SubscriptionManagementScreen({super.key});

  @override
  State<SubscriptionManagementScreen> createState() => _SubscriptionManagementScreenState();
}

class _SubscriptionManagementScreenState extends State<SubscriptionManagementScreen> {
  String _selectedPG = 'All PGs';
  String _selectedPlan = 'All Plans';

  final List<String> _pgs = ['All PGs', 'PG Sunshine', 'PG Royal', 'PG Comfort', 'PG Elite'];
  final List<String> _plans = ['All Plans', 'Basic', 'Premium', 'Enterprise'];

  final List<Map<String, dynamic>> _subscriptions = [
    {
      'id': 'SUB001',
      'pgName': 'PG Sunshine',
      'planName': 'Premium',
      'status': 'Active',
      'startDate': '2024-01-01',
      'endDate': '2024-12-31',
      'amount': 2999,
      'billingCycle': 'Monthly',
      'features': [
        'Unlimited Tenants',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
        'API Access',
        'Bulk SMS',
      ],
      'nextBilling': '2024-12-01',
      'autoRenew': true,
    },
    {
      'id': 'SUB002',
      'pgName': 'PG Royal',
      'planName': 'Basic',
      'status': 'Active',
      'startDate': '2024-02-01',
      'endDate': '2024-12-31',
      'amount': 999,
      'billingCycle': 'Monthly',
      'features': [
        'Up to 20 Tenants',
        'Basic Analytics',
        'Email Support',
        'Standard Features',
      ],
      'nextBilling': '2024-12-01',
      'autoRenew': true,
    },
    {
      'id': 'SUB003',
      'pgName': 'PG Comfort',
      'planName': 'Enterprise',
      'status': 'Expired',
      'startDate': '2024-01-01',
      'endDate': '2024-11-30',
      'amount': 4999,
      'billingCycle': 'Monthly',
      'features': [
        'Unlimited Everything',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
        'API Access',
        'Bulk SMS',
        'White Label',
        'Dedicated Manager',
      ],
      'nextBilling': '2024-11-30',
      'autoRenew': false,
    },
    {
      'id': 'SUB004',
      'pgName': 'PG Elite',
      'planName': 'Premium',
      'status': 'Trial',
      'startDate': '2024-11-15',
      'endDate': '2024-12-15',
      'amount': 0,
      'billingCycle': 'Trial',
      'features': [
        'Unlimited Tenants',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
        'API Access',
        'Bulk SMS',
      ],
      'nextBilling': '2024-12-15',
      'autoRenew': false,
    },
  ];

  final List<Map<String, dynamic>> _plansList = [
    {
      'name': 'Basic',
      'price': 999,
      'billingCycle': 'Monthly',
      'description': 'Perfect for small PGs',
      'features': [
        'Up to 20 Tenants',
        'Basic Analytics',
        'Email Support',
        'Standard Features',
        'Mobile App Access',
        'Basic Reports',
      ],
      'color': const Color(0xFF3B82F6),
      'bgColor': const Color(0xFFEFF6FF),
      'popular': false,
    },
    {
      'name': 'Premium',
      'price': 2999,
      'billingCycle': 'Monthly',
      'description': 'Most popular choice',
      'features': [
        'Unlimited Tenants',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
        'API Access',
        'Bulk SMS',
        'Advanced Reports',
        'Multi-PG Management',
      ],
      'color': const Color(0xFF8B5CF6),
      'bgColor': const Color(0xFFF3E8FF),
      'popular': true,
    },
    {
      'name': 'Enterprise',
      'price': 4999,
      'billingCycle': 'Monthly',
      'description': 'For large operations',
      'features': [
        'Unlimited Everything',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
        'API Access',
        'Bulk SMS',
        'White Label',
        'Dedicated Manager',
        'Custom Integrations',
        'Advanced Security',
      ],
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFF0FDF4),
      'popular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
        title: Text(
          'Subscription Management',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddSubscriptionDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildOverviewCard(),
            const SizedBox(height: 24),
            _buildFiltersSection(),
            const SizedBox(height: 24),
            _buildSubscriptionsList(),
            const SizedBox(height: 24),
            _buildPlansSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    final activeSubscriptions = _subscriptions.where((s) => s['status'] == 'Active').length;
    final totalRevenue = _subscriptions
        .where((s) => s['status'] == 'Active')
        .fold<num>(0, (sum, s) => sum + (s['amount'] ?? 0));
    final expiringSoon = _subscriptions.where((s) => s['status'] == 'Active' && _isExpiringSoon(s['endDate'])).length;

    return Container(
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
                'Subscription Overview',
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
                  'This month',
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
              _buildOverviewStat('Active', activeSubscriptions.toString(), Colors.white),
              const SizedBox(width: 20),
              _buildOverviewStat('Revenue', '₹$totalRevenue', const Color(0xFFFFD700)),
              const SizedBox(width: 20),
              _buildOverviewStat('Expiring', expiringSoon.toString(), const Color(0xFFFF6B6B)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(String label, String value, Color color) {
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

  Widget _buildFiltersSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildFilterDropdown(
                    'PG',
                    _selectedPG,
                    _pgs,
                    (value) => setState(() => _selectedPG = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFilterDropdown(
                    'Plan',
                    _selectedPlan,
                    _plans,
                    (value) => setState(() => _selectedPlan = value!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF1F2937),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionsList() {
    final filteredSubscriptions = _subscriptions.where((subscription) {
      final matchesPG = _selectedPG == 'All PGs' || subscription['pgName'] == _selectedPG;
      final matchesPlan = _selectedPlan == 'All Plans' || subscription['planName'] == _selectedPlan;
      return matchesPG && matchesPlan;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Active Subscriptions',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredSubscriptions.length,
            itemBuilder: (context, index) {
              return _buildSubscriptionCard(filteredSubscriptions[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> subscription) {
    Color statusColor;
    IconData statusIcon;
    
    switch (subscription['status']) {
      case 'Active':
        statusColor = const Color(0xFF10B981);
        statusIcon = Icons.check_circle;
        break;
      case 'Expired':
        statusColor = const Color(0xFFEF4444);
        statusIcon = Icons.cancel;
        break;
      case 'Trial':
        statusColor = const Color(0xFFF59E0B);
        statusIcon = Icons.schedule;
        break;
      default:
        statusColor = const Color(0xFF6B7280);
        statusIcon = Icons.info;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription['pgName'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${subscription['planName']} Plan',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    subscription['amount'] == 0 ? 'Free Trial' : '₹${subscription['amount']}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      subscription['status'],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 4),
              Text(
                'Valid: ${subscription['startDate']} - ${subscription['endDate']}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.payment,
                size: 14,
                color: const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 4),
              Text(
                'Next: ${subscription['nextBilling']}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showSubscriptionDetails(subscription),
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: Text(
                    'Details',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF667EEA),
                    side: const BorderSide(color: Color(0xFF667EEA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _manageSubscription(subscription),
                  icon: const Icon(Icons.settings, size: 16),
                  label: Text(
                    'Manage',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667EEA),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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

  Widget _buildPlansSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Available Plans',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _plansList.length,
            itemBuilder: (context, index) {
              return _buildPlanCard(_plansList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: plan['popular'] ? plan['color'] : Colors.grey[200]!,
          width: plan['popular'] ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          plan['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        if (plan['popular'])
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: plan['color'],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Popular',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plan['description'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${plan['price']}',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: plan['color'],
                    ),
                  ),
                  Text(
                    plan['billingCycle'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Features:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          ...(plan['features'] as List<String>).map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: plan['color'],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _selectPlan(plan),
              style: ElevatedButton.styleFrom(
                backgroundColor: plan['color'],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Select Plan',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isExpiringSoon(String endDate) {
    final end = DateTime.parse(endDate);
    final now = DateTime.now();
    final difference = end.difference(now).inDays;
    return difference <= 30 && difference >= 0;
  }

  void _showAddSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Add New Subscription',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterDropdown(
              'Select PG',
              _pgs.first,
              _pgs,
              (value) => setState(() {}),
            ),
            const SizedBox(height: 16),
            _buildFilterDropdown(
              'Select Plan',
              _plans.first,
              _plans,
              (value) => setState(() {}),
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
                  content: Text('Subscription added successfully!'),
                  backgroundColor: const Color(0xFF10B981),
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
              'Add',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionDetails(Map<String, dynamic> subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Subscription Details',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PG: ${subscription['pgName']}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Plan: ${subscription['planName']}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: ₹${subscription['amount']}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${subscription['status']}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Auto Renew: ${subscription['autoRenew'] ? 'Yes' : 'No'}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _manageSubscription(Map<String, dynamic> subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Manage Subscription',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text('Edit Subscription'),
              onTap: () {
                Navigator.pop(context);
                // Handle edit
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: Text('Cancel Subscription'),
              onTap: () {
                Navigator.pop(context);
                // Handle cancellation
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: Text('Renew Subscription'),
              onTap: () {
                Navigator.pop(context);
                // Handle renewal
              },
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
        ],
      ),
    );
  }

  void _selectPlan(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Select Plan',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterDropdown(
              'Select PG',
              _pgs.first,
              _pgs,
              (value) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Text(
              'Plan: ${plan['name']} - ₹${plan['price']}/${plan['billingCycle']}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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
                  content: Text('Plan selected successfully!'),
                  backgroundColor: const Color(0xFF10B981),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: plan['color'],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Subscribe',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 