import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class Sidebar extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final VoidCallback onLogout;

  const Sidebar({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Drawer(
      width: 280,
      backgroundColor: colorScheme.surface,
      elevation: 8,
      child: Column(
        children: [
          // Header with close button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: colorScheme.onPrimaryContainer),
                  onPressed: onClose,
                ),
              ],
            ),
          ),

          // User info
          if (user != null) _buildUserInfo(context, user, colorScheme, theme),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  route: user?.role == 'owner'
                      ? '/owner/dashboard'
                      : user?.role == 'manager'
                          ? '/manager/dashboard'
                          : '/tenant/dashboard',
                ),

                if (user?.role == 'owner' || user?.role == 'manager')
                  _buildMenuItem(
                    context,
                    icon: Icons.people_outline,
                    label: 'Tenants',
                    route: '/${user?.role}/tenants',
                  ),

                if (user?.role == 'owner' || user?.role == 'manager')
                  _buildMenuItem(
                    context,
                    icon: Icons.monetization_on_outlined,
                    label: 'Rent Collection',
                    route: '/${user?.role}/rent',
                  ),

                if (user?.role == 'owner')
                  _buildMenuItem(
                    context,
                    icon: Icons.business_outlined,
                    label: 'PG Management',
                    route: '/owner/pg-management',
                  ),

                if (user?.role == 'owner')
                  _buildMenuItem(
                    context,
                    icon: Icons.manage_accounts_outlined,
                    label: 'Manage Managers',
                    route: '/owner/managers',
                  ),

                const Divider(),

                _buildMenuItem(
                  context,
                  icon: Icons.person_outline,
                  label: 'Profile',
                  route: '/profile',
                ),

                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  route: '/settings',
                ),

                _buildMenuItem(
                  context,
                  icon: Icons.help_outline,
                  label: 'Help & Support',
                  route: '/help',
                ),
              ],
            ),
          ),

          // Logout button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.errorContainer,
                  foregroundColor: colorScheme.onErrorContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onLogout,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(
      BuildContext context, User user, ColorScheme colorScheme, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: colorScheme.primaryContainer,
            backgroundImage: user.photoUrl != null
                ? NetworkImage(user.photoUrl!)
                : null,
            child: user.photoUrl == null
                ? Text(
                    user.displayName?.isNotEmpty == true
                        ? user.displayName![0].toUpperCase()
                        : '?',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? 'User',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (user.email != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    user.email!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getRoleColor(user.role).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getRoleColor(user.role).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    user.roleDisplayName,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getRoleColor(user.role),
                      fontWeight: FontWeight.bold,
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

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
  }) {
    final theme = Theme.of(context);
    final isActive = ModalRoute.of(context)?.settings.name == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != route) {
          context.go(route);
        }
        onClose();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      minLeadingWidth: 32,
      dense: true,
      tileColor: isActive
          ? theme.colorScheme.primary.withValues(alpha: 0.1)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'owner':
        return Colors.purple;
      case 'manager':
        return Colors.blue;
      case 'admin':
        return Colors.red;
      case 'tenant':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
