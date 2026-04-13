import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I toggle "Summer Course" switch
Future<void> iToggleSummerCourseSwitch(WidgetTester tester) async {
  // Encontra o botão de alternar (Switch) do curso de verão na tela
  final switchWidget = find.byType(Switch);

  // Simula o clique no switch
  await tester.tap(switchWidget);
  await tester.pumpAndSettle();
}