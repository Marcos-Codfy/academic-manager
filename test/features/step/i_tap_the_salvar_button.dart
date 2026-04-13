import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap the "Salvar" button
Future<void> iTapTheSalvarButton(WidgetTester tester) async {
  // 1. Encontra o botão que contém o texto 'Save' (que é o texto real na UI do HomeView)
  final saveButton = find.widgetWithText(ElevatedButton, 'Save');

  // 2. Simula o clique no botão
  await tester.tap(saveButton);

  // 3. Aguarda qualquer ação assíncrona terminar (como o delay do repositório e a animação do SnackBar)
  await tester.pumpAndSettle();
}