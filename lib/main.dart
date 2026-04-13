// lib/main.dart
import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'repositories/api_discipline_repository.dart'; // <--- UPDATED
import 'viewmodels/discipline_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  // 1. We create the API repository (Data layer connected to Backend)
  // 1. Agora criamos o repositório da API que se conecta ao Backend
  final repository = ApiDisciplineRepository();

  // 2. We inject the repository into the ViewModel (Logic layer)
  // 2. Nós injetamos o repositório no ViewModel (Camada de lógica)
  final viewModel = DisciplineViewModel(repository);

  // 3. We run the app passing the ViewModel
  // 3. Nós rodamos o app passando o ViewModel
  runApp(AcademicApp(viewModel: viewModel));
}

// The main widget that configures the application
class AcademicApp extends StatelessWidget {
  final DisciplineViewModel viewModel;

  const AcademicApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Web',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: HomeView(viewModel: viewModel),
    );
  }
}