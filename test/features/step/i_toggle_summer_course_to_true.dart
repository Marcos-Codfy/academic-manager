import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I toggle summer course to true
Future<void> iToggleSummerCourseToTrue(WidgetTester tester) async {
  // 1. Encontra o botão de alternar (Switch) na tela
  final switchWidget = find.byType(Switch);

  // 2. Simula um toque no botão para mudar seu estado para true
  await tester.tap(switchWidget);

  // 3. Aguarda a tela ser reconstruída com o novo estado visual
  await tester.pumpAndSettle();
}