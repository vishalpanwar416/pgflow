import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';

import 'screens/auth/login_screen.dart';


import 'theme/app_theme.dart';
import 'widgets/app_scaffold.dart';
import 'providers/auth_provider.dart';

import 'screens/owner/owner_dashboard.dart';
import 'screens/owner/pg_management_screen.dart';
import 'screens/owner/tenant_management_screen.dart';
import 'screens/owner/rent_collection_screen.dart';
import 'screens/owner/complaints_management_screen.dart';
import 'screens/owner/notices_management_screen.dart';
import 'screens/owner/broadcast_screen.dart';
import 'screens/owner/subscription_management_screen.dart';
import 'screens/tenant/tenant_dashboard.dart';
import 'screens/manager/manager_dashboard.dart';
import 'models/pg_model.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppTheme.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialize animations
  Animate.restartOnHotReload = true;
  Animate.defaultDuration = const Duration(milliseconds: 350);

  // Demo credentials are available for testing (check AuthProvider.demoCredentials)

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const PGFlowApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/login',
  // Global redirect to handle root path and authentication
  redirect: (context, state) {
    // Handle root path
    if (state.uri.path == '/') {
      return '/login';
    }

    // Handle authentication
    final isLoggedIn = context.read<AuthProvider>().isAuthenticated;
    final isLoggingIn = state.matchedLocation == '/login';

    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }

    if (isLoggedIn && isLoggingIn) {
      final user = context.read<AuthProvider>().currentUser;
      if (user?.role == 'owner') {
        return '/owner/dashboard';
      } else if (user?.role == 'manager') {
        return '/manager/dashboard';
      } else {
        return '/tenant/dashboard';
      }
    }

    return null; // No redirect needed
  },
  routes: [
    // Root route that redirects to login
    GoRoute(
      path: '/',
      redirect: (_, __) => '/login',
    ),

    // Auth routes
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    
    // Owner routes
    GoRoute(
      path: '/owner/dashboard',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AppScaffold(
          title: 'Dashboard',
          child: OwnerDashboard(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
      routes: [
        // PG Management
        GoRoute(
          path: 'pg-management',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'PG Management',
              child: PGManagementScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
        // Tenant Management
        GoRoute(
          path: 'tenant-management',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'Tenant Management',
              child: TenantManagementScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
        // Rent Collection
        GoRoute(
          path: 'rent-collection',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'Rent Collection',
              child: RentCollectionScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
        // Complaints Management
        GoRoute(
          path: 'complaints',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'Complaints',
              child: ComplaintsManagementScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
        // Notices Management
        GoRoute(
          path: 'notices',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'Notices',
              child: NoticesManagementScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
        // Broadcast
        GoRoute(
          path: 'broadcast',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'Broadcast',
              child: BroadcastScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
        // Subscription Management
        GoRoute(
          path: 'subscription',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppScaffold(
              title: 'Subscription',
              child: SubscriptionManagementScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return _buildSlideTransition(animation, child);
            },
          ),
        ),
      ],
    ),
    
    // Tenant routes
    GoRoute(
      path: '/tenant/dashboard',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AppScaffold(
          title: 'Dashboard',
          child: TenantDashboard(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    ),
    
    // Manager routes
    GoRoute(
      path: '/manager/dashboard',
      pageBuilder: (context, state) {
        final defaultPG = PG(
          pgId: 'default_pg_id',
          ownerId: 'default_owner_id',
          pgName: 'Default PG',
          address: '123 Main St, City',
          createdAt: DateTime.now(),
          totalRooms: 10,
          occupiedRooms: 5,
        );
        
        return CustomTransitionPage(
          key: state.pageKey,
          child: AppScaffold(
            title: 'Manager Dashboard',
            child: ManagerDashboard(assignedPG: defaultPG),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

class PGFlowApp extends StatelessWidget {
  const PGFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PG Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: _router,
      builder: (context, child) {
        return Animate(
          effects: const [FadeEffect()],
          child: child!,
        );
      },
    );
  }
}

// Handle login success and redirect based on user role
String handleLoginSuccess(BuildContext context, String role) {
  switch (role.toLowerCase()) {
    case 'owner':
      return '/owner/dashboard';
    case 'manager':
      return '/manager/dashboard';
    case 'tenant':
    default:
      return '/tenant/dashboard';
  }
}

SlideTransition _buildSlideTransition(Animation<double> animation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    )),
    child: child,
  );
}
