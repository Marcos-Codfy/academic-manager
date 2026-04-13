import 'package:flutter_test/flutter_test.dart';
import 'package:academic_web/main.dart'; // Importa o arquivo principal
import 'package:academic_web/repositories/discipline_repository.dart';
import 'package:academic_web/viewmodels/discipline_viewmodel.dart';

/// Usage: Given the app is running
Future<void> theAppIsRunning(WidgetTester tester) async {
  // 1. Cria o repositório e o viewmodel para o teste (como no main.dart)
  final repository = DisciplineRepository();
  final viewModel = DisciplineViewModel(repository);

  // 2. Inicializa o aplicativo no ambiente de teste
  await tester.pumpWidget(AcademicApp(viewModel: viewModel));

  // 3. Espera todas as animações e carregamentos iniciais terminarem
  await tester.pumpAndSettle();
}