import 'package:mysql1/mysql1.dart';
import '../model/Cardapio.dart';
class Connection {
  late MySqlConnection conn;

  Connection({ required conn });

  static Future<MySqlConnection> getConnection() async{
      MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
      host: '143.106.241.3',
      port: 3306,
      user: 'cl201605',
      password: 'cl*20122005',
      db: 'cl201605',
    ));

    print(conn.toString());

    // print(conn == null);
    return conn;
  }

  Future<Iterable<Cardapio>> getCardapio() async{
    final results = await conn.query('SELECT principal,guarnicao,salada,sobremesa,suco FROM Cardapio;');
    return results.map((row) => Cardapio.fromMap(row.fields));
    
  }
}