import 'package:flutter/material.dart';
import '../models/discipline_model.dart';
import '../repositories/discipline_repository.dart';

// ViewModel manages the state and business logic of the View
// O ViewModel gerencia o estado e a regra de negócios da View (Tela)
class DisciplineViewModel extends ChangeNotifier {
  final DisciplineRepository repository;

  // Constructor receives the repository (Dependency Injection)
  // O construtor recebe o repositório (Injeção de Dependência)
  DisciplineViewModel(this.repository);

  // App State (Estado do App)
  List<Discipline> disciplines = [];
  bool isLoading = false;

  // Load disciplines from the database
  // Carrega as disciplinas do banco de dados
  Future<void> loadDisciplines() async {
    isLoading = true;
    // Tells the UI to rebuild and show a loading spinner
    // Avisa a interface para recarregar e mostrar um ícone de carregamento
    notifyListeners();

    disciplines = await repository.getDisciplines();

    isLoading = false;
    notifyListeners(); // Avisa a interface que acabou de carregar
  }

  // Add a new discipline to the system
  // Adiciona uma nova disciplina ao sistema
  Future<void> addDiscipline(Discipline discipline) async {
    isLoading = true;
    notifyListeners();

    await repository.addDiscipline(discipline);
    await loadDisciplines(); // Reloads the list (Recarrega a lista)
  }

  // Update an existing discipline
  // Atualiza uma disciplina existente
  Future<void> updateDiscipline(String oldTitle, Discipline updatedDiscipline) async {
    isLoading = true;
    notifyListeners();

    await repository.updateDiscipline(oldTitle, updatedDiscipline);
    await loadDisciplines(); // Recarrega a lista com os dados atualizados
  }

  // Remove a discipline by its title
  // Remove uma disciplina pelo seu título
  Future<void> deleteDiscipline(String title) async {
    isLoading = true;
    notifyListeners();

    await repository.deleteDiscipline(title);
    await loadDisciplines();
  }
}