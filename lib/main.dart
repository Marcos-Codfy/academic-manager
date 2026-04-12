// lib/main.dart
import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'repositories/discipline_repository.dart';
import 'viewmodels/discipline_viewmodel.dart';
import 'views/home_view.dart';

// The main function is the starting point of all Flutter apps
// A função main é o ponto de partida de todos os apps Flutter
void main() {
  // 1. We create the repository (Data layer)
  // 1. Nós criamos o repositório (Camada de dados)
  final repository = DisciplineRepository();

  // 2. We inject the repository into the ViewModel (Logic layer)
  // 2. Nós injetamos o repositório no ViewModel (Camada de lógica)
  final viewModel = DisciplineViewModel(repository);

  // 3. We run the app passing the ViewModel
  // 3. Nós rodamos o app passando o ViewModel
  runApp(AcademicApp(viewModel: viewModel));
}

// The main widget that configures the application
// O widget principal que configura a aplicação
class AcademicApp extends StatelessWidget {
  final DisciplineViewModel viewModel;

  const AcademicApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Web',
      // We apply the minimalist light theme we created
      // Nós aplicamos o tema claro minimalista que criamos
      theme: AppTheme.lightTheme,
      // We hide the debug banner on the top right
      // Escondemos a faixa de debug no canto superior direito
      debugShowCheckedModeBanner: false,
      // We set the initial screen (HomeView)
      // Definimos a tela inicial (HomeView)
      home: HomeView(viewModel: viewModel),
    );
  }
}