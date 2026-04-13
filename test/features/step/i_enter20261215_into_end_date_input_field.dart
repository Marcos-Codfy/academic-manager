import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "2026-12-15" into End Date input field
Future<void> iEnter20261215IntoEndDateInputField(WidgetTester tester) async {
  // Encontra o campo de texto pelo label 'End Date'
  final endDateField = find.widgetWithText(TextField, 'End Date');

  // Digita a data
  await tester.enterText(endDateField, '2026-12-15');

  // Atualiza a tela
  await tester.pumpAndSettle();
}