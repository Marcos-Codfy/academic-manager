// test/features/step/i_enter_software_quality_into_title_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "Software Quality" into title input field
Future<void> iEnterSoftwareQualityIntoTitleInputField(WidgetTester tester) async {
  // 1. Encontra o campo de texto que possui o rótulo 'Title'
  final titleField = find.widgetWithText(TextField, 'Title');

  // 2. Simula a digitação do texto "Software Quality" no campo encontrado
  await tester.enterText(titleField, 'Software Quality');

  // 3. Atualiza a tela após a digitação
  await tester.pumpAndSettle();
}