import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap the delete icon
Future<void> iTapTheDeleteIcon(WidgetTester tester) async {
  // Encontra o ícone de lixeira
  final deleteIcon = find.byIcon(Icons.delete_outline);

  // Rola a tela (scroll) até garantir que o ícone esteja visível antes de clicar
  await tester.ensureVisible(deleteIcon);

  // Agora sim, clica no ícone
  await tester.tap(deleteIcon);

  // Aguarda a animação e a exclusão
  await tester.pumpAndSettle();
}
