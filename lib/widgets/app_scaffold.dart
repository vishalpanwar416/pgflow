import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import 'sidebar.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showAppBar;

  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showAppBar = true,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  bool _isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        // Main content
        Scaffold(
          appBar: widget.showAppBar
              ? AppBar(
                  title: Text(
                    widget.title ?? 'PG Flow',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      setState(() {
                        _isSidebarOpen = true;
                      });
                    },
                  ),
                  actions: widget.actions,
                  backgroundColor: colorScheme.surface,
                  elevation: 0,
                  iconTheme: IconThemeData(color: colorScheme.onSurface),
                  titleTextStyle: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
          body: widget.child,
        ),

        // Sidebar overlay
        if (_isSidebarOpen)
          GestureDetector(
            onTap: () {
              setState(() {
                _isSidebarOpen = false;
              });
            },
            child: Container(
              color: Colors.black54,
            ),
          ),

        // Sidebar
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          left: _isSidebarOpen ? 0 : -300,
          top: 0,
          bottom: 0,
          width: 280,
          child: Material(
            color: colorScheme.surface,
            elevation: 8,
            child: Sidebar(
              isOpen: _isSidebarOpen,
              onClose: () {
                setState(() {
                  _isSidebarOpen = false;
                });
              },
              onLogout: () async {
                await authProvider.logout();
                await Future.delayed(const Duration(milliseconds: 300));
                if (!mounted) return;
                if (mounted) {
                  context.go('/login');
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('/login')));
              },
            ),
          ),
        ),
      ],
    );
  }
}
