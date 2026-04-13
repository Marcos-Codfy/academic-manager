import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "Software Architecture" into title input field
Future<void> iEnterSoftwareArchitectureIntoTitleInputField(WidgetTester tester) async {
  // Encontra o campo de texto que possui o rótulo 'Title'
  final titleField = find.widgetWithText(TextField, 'Title');

  // Simula a digitação do novo texto, substituindo o antigo
  await tester.enterText(titleField, 'Software Architecture');

  // Atualiza a tela após a digitação
  await tester.pumpAndSettle();
}