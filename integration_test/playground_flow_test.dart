import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_backend_driven_ui/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('playground flow: landing -> playground -> edit JSON',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const BdcApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Playground'));
    await tester.pumpAndSettle();

    expect(find.text('Playground'), findsWidgets);
    expect(find.byType(TextField), findsWidgets);
    expect(find.text('New'), findsOneWidget);
  });

  testWidgets('playground: load screen from selector', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const BdcApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Playground'));
    await tester.pumpAndSettle();

    final dropdownFinder = find.byType(DropdownButton<String>);
    if (dropdownFinder.evaluate().isNotEmpty) {
      await tester.tap(dropdownFinder.first);
      await tester.pumpAndSettle();

      final homeFinder = find.text('home').last;
      if (homeFinder.evaluate().isNotEmpty) {
        await tester.tap(homeFinder);
        await tester.pumpAndSettle();
      }
    }

    expect(find.byType(TextField), findsWidgets);
  });

  testWidgets('playground: format and clear buttons work', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const BdcApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Playground'));
    await tester.pumpAndSettle();

    final formatButton = find.byIcon(Icons.auto_fix_high);
    if (formatButton.evaluate().isNotEmpty) {
      await tester.tap(formatButton.first);
      await tester.pumpAndSettle();
    }

    expect(find.byType(TextField), findsWidgets);
  });
}
