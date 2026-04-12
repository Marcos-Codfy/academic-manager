import '../models/discipline_model.dart';

// Repository pattern isolates data access
// O padrão Repository isola o acesso a dados para deixar o app organizado
class DisciplineRepository {
  // In-memory list to simulate our database for now
  // Lista em memória para simular nosso banco de dados por enquanto
  final List<Discipline> _disciplines = [];

  // Create (Criar)
  Future<void> addDiscipline(Discipline discipline) async {
    // Simulating network/database delay (Simulando delay de rede/banco)
    await Future.delayed(const Duration(milliseconds: 300));
    _disciplines.add(discipline);
  }

  // Read (Ler)
  Future<List<Discipline>> getDisciplines() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _disciplines;
  }

  // Delete (Deletar)
  Future<void> deleteDiscipline(String title) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _disciplines.removeWhere((d) => d.title == title);
  }
}