import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "30" into seats input field
Future<void> iEnter30IntoSeatsInputField(WidgetTester tester) async {
  // Encontra o campo de vagas
  final seatsField = find.widgetWithText(TextField, 'Seats');

  // Digita o número 30
  await tester.enterText(seatsField, '30');

  await tester.pumpAndSettle();
}