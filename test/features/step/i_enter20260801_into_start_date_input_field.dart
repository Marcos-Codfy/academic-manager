import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "2026-08-01" into Start Date input field
Future<void> iEnter20260801IntoStartDateInputField(WidgetTester tester) async {
  // Encontra o campo de texto pelo label 'Start Date'
  final startDateField = find.widgetWithText(TextField, 'Start Date');

  // Digita a data
  await tester.enterText(startDateField, '2026-08-01');

  // Atualiza a tela
  await tester.pumpAndSettle();
}