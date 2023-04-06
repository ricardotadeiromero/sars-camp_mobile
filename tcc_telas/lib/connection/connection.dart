import 'dart:convert';
import '../model/Cardapio.dart';
import 'package:http/http.dart' as http;

class Connection {


  static Future<List<Cardapio>> getCardapio(String data) async {
    var url = Uri.parse("http://localhost:3000/api/cardapio/'${data}'");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final cardapios = jsonDecode(response.body) as List;
      return cardapios.map((cardapio) => Cardapio.fromMap(cardapio)).toList();
    } else {
      throw Exception('Falha ao carregar cardápio');
    }
  }
}
