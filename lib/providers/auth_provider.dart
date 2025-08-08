import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  // Demo credentials for testing
  static const Map<String, Map<String, String>> _demoCredentials = {
    'owner': {
      'email': 'owner@demo.com',
      'phone': 'owner123',
      'password': '123456',
    },
    'manager': {
      'email': 'manager@demo.com',
      'phone': 'manager123',
      'password': '123456',
    },
    'tenant': {
      'email': 'tenant@demo.com',
      'phone': 'tenant123',
      'password': '123456',
    },
  };

  // Simulated login - replace with your actual authentication logic
  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Check if credentials match demo credentials
      String? userRole;
      
      for (final entry in _demoCredentials.entries) {
        final role = entry.key;
        final credentials = entry.value;
        
        if (credentials['email'] == email && credentials['password'] == password) {
          userRole = role;
          break;
        }
      }
      
      if (userRole != null) {
        // Create user based on role
        _currentUser = User(
          uid: 'demo_${userRole}_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: _getDisplayName(userRole),
          photoUrl: 'https://ui-avatars.com/api/?name=${_getDisplayName(userRole)}&background=random',
          role: userRole,
        );
      } else {
        throw Exception('Invalid credentials. Please use demo credentials.');
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Phone-based login for demo
  Future<void> loginWithPhone(String phone, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Check if credentials match demo credentials
      String? userRole;
      
      for (final entry in _demoCredentials.entries) {
        final role = entry.key;
        final credentials = entry.value;
        
        if (credentials['phone'] == phone && credentials['password'] == password) {
          userRole = role;
          break;
        }
      }
      
      if (userRole != null) {
        // Create user based on role
        _currentUser = User(
          uid: 'demo_${userRole}_${DateTime.now().millisecondsSinceEpoch}',
          email: '$phone@demo.com',
          displayName: _getDisplayName(userRole),
          photoUrl: 'https://ui-avatars.com/api/?name=${_getDisplayName(userRole)}&background=random',
          role: userRole,
        );
      } else {
        throw Exception('Invalid credentials. Please use demo credentials.');
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _getDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'owner':
        return 'Demo Owner';
      case 'manager':
        return 'Demo Manager';
      case 'tenant':
        return 'Demo Tenant';
      default:
        return 'Demo User';
    }
  }

  // Get demo credentials for UI display
  static Map<String, Map<String, String>> get demoCredentials => _demoCredentials;

  Future<void> logout() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulate logout delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      _currentUser = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Check if user is already logged in (e.g., from shared preferences)
  Future<void> checkAuthStatus() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Check if user is logged in (e.g., from shared preferences)
      // For now, we'll just clear any existing user
      _currentUser = null;
      
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class User {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String role;

  User({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.role,
  });

  // Helper getter for role display name
  String get roleDisplayName {
    switch (role.toLowerCase()) {
      case 'owner':
        return 'Owner';
      case 'manager':
        return 'Manager';
      case 'tenant':
        return 'Tenant';
      default:
        return 'User';
    }
  }
}
