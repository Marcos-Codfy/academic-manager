// lib/repositories/i_discipline_repository.dart

import '../models/discipline_model.dart';

// Contrato (interface) que define o que qualquer repositório de disciplinas DEVE fazer.
// Seguindo o princípio SOLID de Inversão de Dependência (D), o ViewModel
// depende desta abstração, não de implementações concretas.
abstract class IDisciplineRepository {
  Future<List<Discipline>> getDisciplines();
  Future<void> addDiscipline(Discipline discipline);
  Future<void> updateDiscipline(String oldTitle, Discipline updatedDiscipline);
  Future<void> deleteDiscipline(String title);
}
