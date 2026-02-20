// Level 12 - Testing: Integration test.
// IntegrationTestWidgetsFlutterBinding.ensureInitialized(); lalu testWidgets (full app flow).
// Dijalankan dengan: flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full app flow: counter increments', (WidgetTester tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byKey(const Key('increment_fab')));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('increment_fab')));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsOneWidget);
  });
}
