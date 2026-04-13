// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';

import 'package:academic_web/main.dart';
import 'package:academic_web/repositories/discipline_repository.dart';
import 'package:academic_web/viewmodels/discipline_viewmodel.dart';

void main() {
  testWidgets('App starts successfully smoke test', (WidgetTester tester) async {
    // 1. Cria as dependências necessárias (Repositório e ViewModel)
    final repository = DisciplineRepository();
    final viewModel = DisciplineViewModel(repository);

    // 2. Constrói o aplicativo passando o ViewModel para a classe AcademicApp
    await tester.pumpWidget(AcademicApp(viewModel: viewModel));

    // 3. Aguarda todas as animações e carregamentos iniciais terminarem
    await tester.pumpAndSettle();

    // 4. Verifica se o texto do AppBar (Manager Academic) está na tela,
    // o que confirma que o aplicativo iniciou corretamente sem o "MyApp".
    expect(find.text('Manager Academic'), findsOneWidget);
  });
}