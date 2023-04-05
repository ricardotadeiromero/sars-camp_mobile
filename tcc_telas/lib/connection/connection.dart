import 'package:mysql1/mysql1.dart';
import '../model/Cardapio.dart';

class Connection {
  late MySqlConnection conn;

  static Future<MySqlConnection> getConnection() async {
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
      host: '143.106.241.3',
      port: 3306,
      user: 'cl201605',
      password: 'cl*20122005',
      db: 'cl201605',
    ));

    // print(conn == null);
    return conn;
  }

  static Future<Iterable<Cardapio>> getCardapio() async {
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
      host: '143.106.241.3',
      port: 3306,
      user: 'cl201605',
      password: 'cl*20122005',
      db: 'cl201605',
    ));
    final results = await conn.query(
        'SELECT principal,guarnicao,salada,sobremesa,suco FROM Cardapio;');
    return results.map((row) => Cardapio.fromMap(row.fields));
  }
}
