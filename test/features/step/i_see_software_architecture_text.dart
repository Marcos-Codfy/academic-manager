import 'package:flutter_test/flutter_test.dart';

/// Usage: I see "Software Architecture" text
Future<void> iSeeSoftwareArchitectureText(WidgetTester tester) async {
  // Verifica se o texto "Software Architecture" aparece na lista de disciplinas na tela.
  expect(find.text('Software Architecture'), findsWidgets);
}