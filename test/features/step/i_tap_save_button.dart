import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap "Save" button
Future<void> iTapSaveButton(WidgetTester tester) async {
  // Encontra o botão de salvar pelo texto 'Save'
  final saveButton = find.widgetWithText(ElevatedButton, 'Save');

  // Clica no botão
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}