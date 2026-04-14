// lib/viewmodels/discipline_viewmodel.dart

import 'package:flutter/material.dart';
import '../models/discipline_model.dart';
import '../repositories/i_discipline_repository.dart';

// O ViewModel agora depende da ABSTRAÇÃO (IDisciplineRepository),
// não de uma implementação concreta. Isso é o "D" do SOLID.
// Qualquer repositório (memória ou API) pode ser injetado aqui.
class DisciplineViewModel extends ChangeNotifier {
  final IDisciplineRepository repository;

  DisciplineViewModel(this.repository);

  List<Discipline> disciplines = [];
  bool isLoading = false;

  Future<void> loadDisciplines() async {
    isLoading = true;
    notifyListeners();

    disciplines = await repository.getDisciplines();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addDiscipline(Discipline discipline) async {
    isLoading = true;
    notifyListeners();

    await repository.addDiscipline(discipline);
    await loadDisciplines();
  }

  Future<void> updateDiscipline(String oldTitle, Discipline updatedDiscipline) async {
    isLoading = true;
    notifyListeners();

    await repository.updateDiscipline(oldTitle, updatedDiscipline);
    await loadDisciplines();
  }

  Future<void> deleteDiscipline(String title) async {
    isLoading = true;
    notifyListeners();

    await repository.deleteDiscipline(title);
    await loadDisciplines();
  }
}