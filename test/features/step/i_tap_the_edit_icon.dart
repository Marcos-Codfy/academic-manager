import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap the edit icon
Future<void> iTapTheEditIcon(WidgetTester tester) async {
  // Encontra o ícone de edição (vamos usar Icons.edit no nosso layout em breve)
  final editIcon = find.byIcon(Icons.edit);

  // Rola a tela até garantir que o ícone esteja visível antes de clicar
  await tester.ensureVisible(editIcon);

  // Simula o clique no ícone
  await tester.tap(editIcon);

  // Aguarda as animações (como os campos sendo preenchidos com os dados da disciplina)
  await tester.pumpAndSettle();
}