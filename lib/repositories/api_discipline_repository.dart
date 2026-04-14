// lib/repositories/api_discipline_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/discipline_model.dart';
import 'i_discipline_repository.dart';

// Implementação real do repositório que se comunica com o Backend.
// Implementa IDisciplineRepository diretamente — sem herdar do repositório
// de memória, seguindo o princípio de Segregação de Interfaces (SOLID).
class ApiDisciplineRepository implements IDisciplineRepository {
  final String apiUrl = 'http://localhost:8080/disciplines';

  @override
  Future<void> addDiscipline(Discipline discipline) async {
    await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(discipline.toJson()),
    );
  }

  @override
  Future<List<Discipline>> getDisciplines() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Discipline.fromJson(json)).toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erro de conexão com a API: $e');
    }
    return [];
  }

  @override
  Future<void> updateDiscipline(String oldTitle, Discipline updatedDiscipline) async {
    final encodedTitle = Uri.encodeComponent(oldTitle);
    await http.put(
      Uri.parse('$apiUrl/$encodedTitle'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedDiscipline.toJson()),
    );
  }

  @override
  Future<void> deleteDiscipline(String title) async {
    final encodedTitle = Uri.encodeComponent(title);
    await http.delete(Uri.parse('$apiUrl/$encodedTitle'));
  }
}