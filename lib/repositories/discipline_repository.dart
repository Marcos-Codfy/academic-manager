// lib/repositories/discipline_repository.dart

import '../models/discipline_model.dart';
import 'i_discipline_repository.dart';

// Implementação em memória do repositório.
// Usada nos testes para não depender de rede ou banco de dados.
class DisciplineRepository implements IDisciplineRepository {
  final List<Discipline> _disciplines = [];

  @override
  Future<void> addDiscipline(Discipline discipline) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _disciplines.add(discipline);
  }

  @override
  Future<List<Discipline>> getDisciplines() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_disciplines);
  }

  @override
  Future<void> updateDiscipline(String oldTitle, Discipline updatedDiscipline) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _disciplines.indexWhere((d) => d.title == oldTitle);
    if (index != -1) {
      _disciplines[index] = updatedDiscipline;
    }
  }

  @override
  Future<void> deleteDiscipline(String title) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _disciplines.removeWhere((d) => d.title == title);
  }
}