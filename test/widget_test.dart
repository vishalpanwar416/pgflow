// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pg_manager_app/main.dart';
import 'package:pg_manager_app/providers/auth_provider.dart';

void main() {
  testWidgets('PG Flow app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const PGFlowApp(),
      ),
    );

    // Verify that the app loads with login screen
    expect(find.text('PG Flow'), findsOneWidget);
  });
}
