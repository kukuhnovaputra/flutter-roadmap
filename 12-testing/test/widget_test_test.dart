// Level 12 - Testing: Widget test.
// testWidgets(), pumpWidget(), find, tap, expect.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart';

void main() {
  testWidgets('counter starts at 0', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('counter increments when FAB tapped', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byKey(const Key('increment_fab')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byKey(const Key('increment_fab')));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('counter value has Key', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byKey(const Key('counter_value')), findsOneWidget);
  });
}
