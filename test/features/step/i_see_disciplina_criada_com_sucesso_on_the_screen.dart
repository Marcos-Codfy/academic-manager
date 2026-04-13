import 'package:flutter_test/flutter_test.dart';

/// Usage: I see "Disciplina criada com sucesso" on the screen
Future<void> iSeeDisciplinaCriadaComSucessoOnTheScreen(WidgetTester tester) async {
  // 1. Verifica se a mensagem de sucesso do SnackBar aparece exatamente uma vez na tela
  expect(find.text('Disciplina criada com sucesso'), findsOneWidget);
}