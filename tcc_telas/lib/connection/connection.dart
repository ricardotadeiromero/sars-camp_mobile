import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import '../model/cardapio.dart';
import 'package:http/http.dart' as http;

class Connection {
  static void startApi() async {
    var url = Uri.parse("https://sars-camp.onrender.com");
    final response = await http.get(url);
  }

  static Future<List<dynamic>> getCardapio() async {
    var url = Uri.parse("http://192.168.15.7:3000/cardapio/semana/21");
    final response = await http.get(url);
    print("fon");
    print(response);
    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 1));
      final cardapios = jsonDecode(response.body);
      print(cardapios);
      print(cardapios.runtimeType);
      return cardapios;
    } else if (response.statusCode == 404) {
      throw HttpException('Cardápio indisponível!');
    } else
      throw HttpException('Falha ao carregar cardápio');
  }

  static Future<String> getSaldo2(String ra, String senha) async {
    var url = Uri.parse("http://192.168.15.7:3000/saldo");
    final body = jsonEncode(<String, String>{"ra": ra, "senha": senha});
    print(body);
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 403) {
      throw const HttpException('RA ou senha inválidos!');
    } else {
      var res = jsonDecode(response.body);
      return 'R\$' + res["saldo"].toString();
    }
  }

  static Future<String> getSaldo(String ra, String senha) async {
    var url = Uri.parse("http://192.168.15.7/saldo/${ra}/${senha}");

    final response = await http.get(url, headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8"
    });

    var res = jsonDecode(response.body);

    return res[0]["Saldo"].toString();
  }

  static Future<bool> getFeriado(DateTime data) async {
    var date = DateFormat("yyyy-MM-dd").format(data);
    var url = Uri.parse("http://192.168.15.7:3000/date/dia/${date}");

    final response = await http.get(url);
    var res = jsonDecode(response.body) as bool;
    return res;
  }
}
