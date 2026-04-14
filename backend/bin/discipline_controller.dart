// backend/bin/discipline_controller.dart

import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

// Responsabilidade única: definir e tratar as rotas HTTP de disciplinas.
// Recebe a conexão já aberta pelo database.dart via injeção de dependência.
Router buildDisciplineRouter(Connection connection) {
  final router = Router();

  // [GET] Retorna todas as disciplinas
  router.get('/disciplines', (Request req) async {
    final result = await connection.execute(
      'SELECT id, title, start_date, end_date, seats, is_summer FROM disciplines',
    );

    final list = result.map((row) => {
      'id': row[0].toString(),
      'title': row[1],
      'startDate': row[2],
      'endDate': row[3],
      'seats': row[4],
      'isSummer': row[5],
    }).toList();

    return Response.ok(
      jsonEncode(list),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // [POST] Cria uma nova disciplina
  router.post('/disciplines', (Request req) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);

    try {
      await connection.execute(
        Sql.named(
          'INSERT INTO disciplines (title, start_date, end_date, seats, is_summer) '
              'VALUES (@title, @start, @end, @seats, @summer)',
        ),
        parameters: {
          'title': data['title'],
          'start': data['startDate'],
          'end': data['endDate'],
          'seats': data['seats'],
          'summer': data['isSummer'],
        },
      );
      return Response.ok(jsonEncode({'message': 'Created'}));
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({'error': e.toString()}),
      );
    }
  });

  // [PUT] Atualiza uma disciplina existente pelo título original
  router.put('/disciplines/<oldTitle>', (Request req, String oldTitle) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);
    final decodedOldTitle = Uri.decodeComponent(oldTitle);

    await connection.execute(
      Sql.named(
        'UPDATE disciplines SET title = @title, start_date = @start, '
            'end_date = @end, seats = @seats, is_summer = @summer '
            'WHERE title = @oldTitle',
      ),
      parameters: {
        'title': data['title'],
        'start': data['startDate'],
        'end': data['endDate'],
        'seats': data['seats'],
        'summer': data['isSummer'],
        'oldTitle': decodedOldTitle,
      },
    );

    return Response.ok(jsonEncode({'message': 'Updated'}));
  });

  // [DELETE] Remove uma disciplina pelo título
  router.delete('/disciplines/<title>', (Request req, String title) async {
    final decodedTitle = Uri.decodeComponent(title);

    await connection.execute(
      Sql.named('DELETE FROM disciplines WHERE title = @title'),
      parameters: {'title': decodedTitle},
    );

    return Response.ok(jsonEncode({'message': 'Deleted'}));
  });

  return router;
}