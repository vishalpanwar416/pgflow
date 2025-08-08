import 'package:flutter/material.dart';
import 'base_owner_screen.dart';
import '../../theme/owner_theme.dart';

// Custom card widget that matches the design system
class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const ModernCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class SubscriptionManagementScreen extends StatefulWidget {
  const SubscriptionManagementScreen({super.key});

  @override
  State<SubscriptionManagementScreen> createState() => _SubscriptionManagementScreenState();
}

class _SubscriptionManagementScreenState extends State<SubscriptionManagementScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
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
    // ... other subscription data ...
  ];

  final List<Map<String, dynamic>> _plansList = [
    {
      'name': 'Basic',
      'price': 999,
      'billingCycle': 'month',
      'color': Colors.blue,
      'features': [
        'Up to 20 Tenants',
        'Basic Analytics',
        'Email Support',
      ],
    },
    {
      'name': 'Premium',
      'price': 2999,
      'billingCycle': 'month',
      'color': Colors.purple,
      'features': [
        'Unlimited Tenants',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
      ],
    },
    {
      'name': 'Enterprise',
      'price': 4999,
      'billingCycle': 'month',
      'color': Colors.orange,
      'features': [
        'Unlimited Everything',
        'Advanced Analytics',
        'Priority Support',
        'Custom Branding',
        'API Access',
      ],
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOwnerScreen(
      title: 'Subscription Management',
      child: SingleChildScrollView(
        padding: OwnerTheme.paddingLarge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentSubscription(),
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

  Widget _buildCurrentSubscription() {
    return ModernCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Plan',
            style: OwnerTheme.textStyleSubtitle1.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Free Trial - Expires in 7 days',
            style: OwnerTheme.textStyleBody1,
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.3,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(OwnerTheme.primaryColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement upgrade subscription
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: OwnerTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Upgrade Now'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Row(
      children: [
        Expanded(
          child: _buildFilterDropdown(
            'Select PG',
            _selectedPG,
            _pgs,
            (value) => setState(() => _selectedPG = value ?? _selectedPG),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildFilterDropdown(
            'Select Plan',
            _selectedPlan,
            _plans,
            (value) => setState(() => _selectedPlan = value ?? _selectedPlan),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          isExpanded: true,
        ),
      ],
    );
  }

  Widget _buildSubscriptionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Subscriptions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ..._subscriptions.where((s) => s['status'] == 'Active').map((subscription) => _buildSubscriptionCard(subscription)),
      ],
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> subscription) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(subscription['pgName'] ?? ''),
        subtitle: Text('${subscription['planName']} - ₹${subscription['amount']}/${subscription['billingCycle']}'),
        trailing: Text(
          subscription['status'] ?? '',
          style: TextStyle(
            color: subscription['status'] == 'Active' ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => _showSubscriptionDetails(subscription),
      ),
    );
  }

  Widget _buildPlansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose a Plan',
          style: OwnerTheme.textStyleSubtitle1.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: _calculateCrossAxisCount(MediaQuery.of(context).size.width),
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: _plansList.map((plan) => _buildPlanCard(plan)).toList(),
        ),
      ],
    );
  }
  
  int _calculateCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
  
  Widget _buildPlanCard(Map<String, dynamic> plan) {
    return ModernCard(
      padding: const EdgeInsets.all(16.0),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${plan['name']} Plan',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: OwnerTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${plan['price']}/${plan['billingCycle']}',
            style: TextStyle(
              fontSize: 16,
              color: OwnerTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          ...(plan['features'] as List<dynamic>).map((feature) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, size: 16, color: OwnerTheme.primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: OwnerTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _selectPlan(plan),
              style: ElevatedButton.styleFrom(
                backgroundColor: plan['color'] as Color? ?? OwnerTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Choose Plan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
        title: const Text('Add New Subscription'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterDropdown(
              'Select PG',
              _pgs.first,
              _pgs,
              (value) {},
            ),
            const SizedBox(height: 16),
            _buildFilterDropdown(
              'Select Plan',
              _plans.first,
              _plans,
              (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement subscription logic
              Navigator.pop(context);
            },
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This feature is coming soon!')),
    );
  }

  void _showSubscriptionDetails(Map<String, dynamic> subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Subscription Details - ${subscription['pgName']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Plan: ${subscription['planName']}'),
              Text('Status: ${subscription['status']}'),
              Text('Amount: ₹${subscription['amount']}'),
              Text('Billing Cycle: ${subscription['billingCycle']}'),
              Text('Start Date: ${subscription['startDate']}'),
              Text('End Date: ${subscription['endDate']}'),
              const SizedBox(height: 16),
              const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...(subscription['features'] as List<dynamic>).map((f) => Text('• $f')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _manageSubscription(Map<String, dynamic> subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage ${subscription['planName']} Subscription'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Change Plan'),
              onTap: () {
                Navigator.pop(context);
                _selectPlan(subscription);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel Subscription'),
              onTap: () {
                // TODO: Implement cancel subscription
                Navigator.pop(context);
                _showComingSoon(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectPlan(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Subscribe to ${plan['name']} Plan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: ₹${plan['price']}/${plan['billingCycle']}'),
            const SizedBox(height: 16),
            const Text('Features:'),
            ...(plan['features'] as List<dynamic>).map((f) => Text('• $f')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement subscription logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Successfully subscribed to ${plan['name']} plan!')),
              );
            },
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }
}