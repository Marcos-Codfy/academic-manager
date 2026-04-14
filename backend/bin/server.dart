// backend/bin/server.dart

import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'database.dart';
import 'discipline_controller.dart';

// Ponto de entrada do backend.
// Responsabilidade única: montar o pipeline e ligar o servidor.
// A conexão com o banco e as rotas ficam em seus próprios arquivos.
Future<void> main() async {
  // 1. Abre a conexão (database.dart cuida dos detalhes)
  final connection = await openDatabaseConnection();

  // 2. Obtém o roteador de disciplinas (discipline_controller.dart cuida das rotas)
  final router = buildDisciplineRouter(connection);

  // 3. Monta o pipeline com CORS e logging
  final handler = Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(router.call);

  // 4. Sobe o servidor
  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Manager Academic API is running on http://localhost:${server.port}');
}