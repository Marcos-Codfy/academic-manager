// test/features/step/the_app_is_running.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:academic_web/main.dart';
import 'package:academic_web/repositories/discipline_repository.dart';
import 'package:academic_web/viewmodels/discipline_viewmodel.dart';

/// Usage: Given the app is running
Future<void> theAppIsRunning(WidgetTester tester) async {
  // Usa o repositório em memória (DisciplineRepository) para os testes,
  // garantindo que não há dependência de rede ou banco de dados.
  final repository = DisciplineRepository();
  final viewModel = DisciplineViewModel(repository);

  await tester.pumpWidget(AcademicApp(viewModel: viewModel));
  await tester.pumpAndSettle();
}