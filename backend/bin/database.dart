// backend/bin/database.dart

import 'package:postgres/postgres.dart';

// Responsabilidade única: gerenciar a conexão com o PostgreSQL.
// Separado do server.dart para que o controlador não precise
// saber como abrir ou fechar o banco.
Future<Connection> openDatabaseConnection() async {
  print('Connecting to PostgreSQL database...');

  final connection = await Connection.open(
    Endpoint(
      host: 'localhost',
      port: 5432,
      database: 'disciplinas_db',
      username: 'postgres',
      password: 'admin',
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  print('Database connected successfully!');

  // Cria a tabela se ainda não existir
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

  return connection;
}