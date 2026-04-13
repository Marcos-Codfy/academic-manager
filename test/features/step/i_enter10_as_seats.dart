import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter "10" as seats
Future<void> iEnter10AsSeats(WidgetTester tester) async {
  // 1. Encontra o campo de texto que tem o rótulo 'Seats'
  final seatsField = find.widgetWithText(TextField, 'Seats');

  // 2. Simula a digitação do número de vagas
  await tester.enterText(seatsField, '10');
  await tester.pumpAndSettle();
}