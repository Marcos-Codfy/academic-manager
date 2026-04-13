// backend/bin/server.dart
import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:postgres/postgres.dart'; // Database (Banco de dados)

// The main function where our backend starts
// A função principal onde nosso backend começa a rodar
Future<void> main() async {
  print('Connecting to PostgreSQL database...');

  // 1. Connects to the database you already have running in Docker
  // 1. Conecta ao banco de dados que você já rodou no Docker
  final connection = await Connection.open(
    Endpoint(
      host: 'localhost',
      port: 5432,
      database: 'disciplinas_db',
      username: 'postgres',
      password: 'admin',
    ),
    // Correction here: The class is ConnectionSettings in postgres v3
    // Correção aqui: A classe se chama ConnectionSettings na versão 3 do postgres
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );
  print('Database connected successfully!');

  // 2. Creates the table if it does not exist
  // 2. Cria a tabela se ela não existir
  await connection.execute('''
    CREATE TABLE IF NOT EXISTS disciplines (
      id SERIAL PRIMARY KEY,
      title TEXT UNIQUE NOT NULL,
      start_date TEXT NOT NULL,
      end_date TEXT NOT NULL,
      seats INTEGER NOT NULL,
      is_summer BOOLEAN NOT NULL
    )
  ''');

  final router = Router();

  // [GET] Read all disciplines (Ler todas as disciplinas)
  router.get('/disciplines', (Request req) async {
    final result = await connection.execute('SELECT id, title, start_date, end_date, seats, is_summer FROM disciplines');
    final list = result.map((row) => {
      'id': row[0].toString(),
      'title': row[1],
      'startDate': row[2],
      'endDate': row[3],
      'seats': row[4],
      'isSummer': row[5],
    }).toList();
    return Response.ok(jsonEncode(list), headers: {'Content-Type': 'application/json'});
  });

  // [POST] Create a new discipline (Criar uma nova disciplina)
  router.post('/disciplines', (Request req) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);
    try {
      await connection.execute(
          Sql.named('INSERT INTO disciplines (title, start_date, end_date, seats, is_summer) VALUES (@title, @start, @end, @seats, @summer)'),
          parameters: {
            'title': data['title'],
            'start': data['startDate'],
            'end': data['endDate'],
            'seats': data['seats'],
            'summer': data['isSummer'],
          }
      );
      return Response.ok(jsonEncode({'message': 'Created'}));
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
    }
  });

  // [PUT] Update a discipline (Editar uma disciplina)
  router.put('/disciplines/<oldTitle>', (Request req, String oldTitle) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);
    final decodedOldTitle = Uri.decodeComponent(oldTitle);

    await connection.execute(
        Sql.named('UPDATE disciplines SET title = @title, start_date = @start, end_date = @end, seats = @seats, is_summer = @summer WHERE title = @oldTitle'),
        parameters: {
          'title': data['title'],
          'start': data['startDate'],
          'end': data['endDate'],
          'seats': data['seats'],
          'summer': data['isSummer'],
          'oldTitle': decodedOldTitle,
        }
    );
    return Response.ok(jsonEncode({'message': 'Updated'}));
  });

  // [DELETE] Delete a discipline (Deletar uma disciplina)
  router.delete('/disciplines/<title>', (Request req, String title) async {
    final decodedTitle = Uri.decodeComponent(title);
    await connection.execute(
        Sql.named('DELETE FROM disciplines WHERE title = @title'),
        parameters: {'title': decodedTitle}
    );
    return Response.ok(jsonEncode({'message': 'Deleted'}));
  });

  // 3. Pipeline with CORS to accept requests from Flutter Web
  // 3. Pipeline com CORS para aceitar requisições do Flutter Web
  final handler = Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Manager Academic API is running on http://localhost:${server.port}');
}