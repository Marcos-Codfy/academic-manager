// lib/models/discipline_model.dart

// Define a estrutura de uma Disciplina
class Discipline {
  // Identificador único da disciplina (opcional para novos registros)
  final String? id;

  // Nome da disciplina
  final String title;

  // Data de início da disciplina
  final DateTime startDate;

  // Data de término da disciplina
  final DateTime endDate;

  // Quantidade total de vagas disponíveis
  final int seats;

  // Indica se a disciplina é de verão (true = sim, false = não)
  final bool isSummer;

  // Construtor da classe (obriga o preenchimento de todos os campos, exceto o id)
  Discipline({
    this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.seats,
    required this.isSummer,
  });
}