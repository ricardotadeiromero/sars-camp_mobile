import 'dart:convert';
import 'dart:io';
import '../model/cardapio.dart';
import 'package:http/http.dart' as http;

class Connection {
  static void startApi() async {
    var url = Uri.parse("https://sars-camp.onrender.com");
    final response = await http.get(url);
  }

  static Future<List<Cardapio>> getCardapio(String data) async {
    var url = Uri.parse("https://sars-camp.onrender.com/cardapio/${data}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final cardapios = jsonDecode(response.body) as List;
      print(cardapios);
      return cardapios.map((cardapio) => Cardapio.fromMap(cardapio)).toList();
    } else if (response.statusCode == 404) {
      throw HttpException('Cardápio indisponível!');
    } else
      throw HttpException('Falha ao carregar cardápio');
  }

  static Future<String> getSaldo2(String ra, String senha) async {
    var url = Uri.parse("https://sars-camp.onrender.com/saldo");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{"ra": ra, "senha": senha}));
    if (response.statusCode == 403) {
      throw const HttpException('RA ou senha inválidos!');
    } else {
      var res = jsonDecode(response.body);
      return 'R\$' + res["saldo"].toString();
    }
  }

  static Future<String> getSaldo(String ra, String senha) async {
    var url = Uri.parse("https://sars-camp.onrender.com/saldo/${ra}/${senha}");

    final response = await http.get(url, headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8"
    });

    var res = jsonDecode(response.body);

    return res[0]["Saldo"].toString();
  }

  static Future<bool> getFeriado(int data) async {
    var url = Uri.parse("https://brasilapi.com.br/api/feriados/v1/${data}");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }
}
