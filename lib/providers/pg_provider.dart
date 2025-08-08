import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pg_model.dart';

class PGNotifier extends StateNotifier<PG?> {
  PGNotifier() : super(null);

  void selectPG(PG pg) {
    state = pg;
  }

  void clearPG() {
    state = null;
  }
}

final selectedPGProvider = StateNotifierProvider<PGNotifier, PG?>((ref) {
  return PGNotifier();
});

final userRoleProvider = StateProvider<String>((ref) => 'owner');

final canViewFinancialDataProvider = Provider<bool>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == 'owner'; // Only owners can see total earnings
});
