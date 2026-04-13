import 'package:flutter_test/flutter_test.dart';

/// Usage: I do not see "Software Quality" text
Future<void> iDoNotSeeSoftwareQualityText(WidgetTester tester) async {
  // Verifica se o texto NÃO existe mais na tela (findsNothing)
  expect(find.text('Software Quality'), findsNothing);
}