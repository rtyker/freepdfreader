// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:freepdfreader/main.dart';

void main() {
  testWidgets('PDF viewer smoke test - initial state and drawer', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial screen shows "Nenhum PDF recebido".
    expect(find.text('Nenhum PDF recebido'), findsOneWidget);

    // Verify that the share button is not visible initially because no PDF is loaded.
    expect(find.byIcon(Icons.share), findsNothing);

    // Verify that the drawer is closed initially.
    expect(find.text('SOBRE'), findsNothing);

    // Open the drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is now open and the "SOBRE" item is visible.
    expect(find.text('SOBRE'), findsOneWidget);

    // Tap the "SOBRE" item.
    await tester.tap(find.text('SOBRE'));
    await tester.pumpAndSettle();

    // Verify that the About Dialog is open and shows contact details.
    expect(find.text('Contato para suporte ou licenciamento comercial:'), findsOneWidget);
    expect(find.text('rtyker@gmail.com'), findsOneWidget);
  });
}
