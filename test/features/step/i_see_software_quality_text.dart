// test/features/step/i_see_software_quality_text.dart
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see "Software Quality" text
Future<void> iSeeSoftwareQualityText(WidgetTester tester) async {
  // 1. Verifica se o texto "Software Quality" aparece na lista de disciplinas na tela.
  // Usamos findsWidgets em vez de findsOneWidget caso o texto apareça em mais de um lugar.
  expect(find.text('Software Quality'), findsWidgets);
}