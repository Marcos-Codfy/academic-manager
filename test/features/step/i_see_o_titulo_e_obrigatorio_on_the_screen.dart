import 'package:flutter_test/flutter_test.dart';

/// Usage: I see "O título é obrigatório" on the screen
Future<void> iSeeOTituloEObrigatorioOnTheScreen(WidgetTester tester) async {
  // 1. Verifica se a mensagem de erro do SnackBar aparece exatamente uma vez na tela
  expect(find.text('O título é obrigatório'), findsOneWidget);
}