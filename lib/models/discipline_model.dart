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

  // Construtor da classe
  Discipline({
    this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.seats,
    required this.isSummer,
  });

  factory Discipline.fromJson(Map<String, dynamic> json) {
    return Discipline(
      id: json['id']?.toString(),
      title: json['title'] as String,
      startDate: DateTime.tryParse(json['startDate'] as String) ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] as String) ?? DateTime.now(),
      seats: json['seats'] as int,
      isSummer: json['isSummer'] as bool,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'seats': seats,
      'isSummer': isSummer,
    };
  }
}