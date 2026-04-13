import 'package:flutter_test/flutter_test.dart';

/// Usage: I see "Discipline created successfully" text
Future<void> iSeeDisciplineCreatedSuccessfullyText(WidgetTester tester) async {
  // Verifica se o SnackBar com a mensagem em português (que é o que o App cospe) aparece na tela
  expect(find.text('Disciplina criada com sucesso'), findsOneWidget);
}