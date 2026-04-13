import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap the delete icon
Future<void> iTapTheDeleteIcon(WidgetTester tester) async {
  // 1. Encontra o ícone de lixeira
  final deleteIcon = find.byIcon(Icons.delete_outline);

  // 2. Avisa ao Flutter para rolar a tela (scroll) até que o ícone fique visível!
  await tester.ensureVisible(deleteIcon);
  await tester.pumpAndSettle(); // Aguarda a animação de rolagem terminar

  // 3. Agora sim, com o ícone na tela, ele clica
  await tester.tap(deleteIcon);
  await tester.pumpAndSettle(); // Aguarda a disciplina ser removida da tela
}