// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:delivery_points/models/ReastaurantModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:delivery_points/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Change pages smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ChangeNotifierProvider(
        builder: (context) => RestaurantModel(), child: MyApp()));

    expect(find.text('Oczekujące'), findsNWidgets(2));
    expect(find.text('Dostarczone'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_up));
    await tester.pumpAndSettle();

    expect(find.text('Oczekujące'), findsOneWidget);
    expect(find.text('Dostarczone'), findsNWidgets(2));
  });
}
