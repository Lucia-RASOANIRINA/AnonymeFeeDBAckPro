// Test minimal de fumée. Les tests complets (offline-first, sync, RLS) sont
// décrits dans docs/TESTING.md.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test : un widget basique se construit',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('FeedbackPro'))),
    );
    expect(find.text('FeedbackPro'), findsOneWidget);
  });
}
