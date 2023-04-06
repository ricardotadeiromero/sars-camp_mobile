import 'dart:convert';

import 'package:mysql1/mysql1.dart';
import '../model/Cardapio.dart';
import 'package:http/http.dart' as http;

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

  static Future<List<Cardapio>> getCardapio(DateTime data) async {
    var url = Uri.parse('http://localhost:3000/api/cardapio/${data}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final cardapios = jsonDecode(response.body) as List;
      return cardapios.map((cardapio) => Cardapio.fromMap(cardapio)).toList();
    } else {
      throw Exception('Falha ao carregar cardápio');
    }
  }
}
