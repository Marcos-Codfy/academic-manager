import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "Teste de Software" as title
Future<void> iEnterTesteDeSoftwareAsTitle(WidgetTester tester) async {
  // 1. Encontra o campo de texto que tem o rótulo (label) 'Title'
  final titleField = find.widgetWithText(TextField, 'Title');

  // 2. Simula a digitação do texto no campo encontrado
  await tester.enterText(titleField, 'Teste de Software');

  // 3. Atualiza a tela após a digitação
  await tester.pumpAndSettle();
}