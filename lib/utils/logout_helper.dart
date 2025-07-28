import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';

void performLogout(BuildContext context, [dynamic ref]) {
  // Reset any providers if ref is provided
  // if (ref != null) {
  //   ref.read(userRoleProvider.notifier).state = null;
  //   ref.read(selectedPGProvider.notifier).state = null;
  // }
  
  // Navigate to login screen and clear stack
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false,
  );
}
