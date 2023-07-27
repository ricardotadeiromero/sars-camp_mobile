import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

const api = "http://192.168.15.7:3000";

class Connection {
  static void startApi() async {
    var url = Uri.parse(api);
    await http.get(url);
  }

  static Future<List<dynamic>> getCardapio() async {
    var url = Uri.parse("$api/cardapio/semana");
    final response = await http.get(url);
    if (kDebugMode) {
      print("fon");
      print(response);
    }
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 1));
      final cardapios = jsonDecode(response.body);
      if (kDebugMode) {
        print(cardapios);
        print(cardapios.runtimeType);
      }
      return cardapios;
    } else if (response.statusCode == 404) {
      throw const HttpException('Cardápio indisponível!');
    } else {
      throw const HttpException('Falha ao carregar cardápio');
    }
  }

  static Future<String> getSaldo(String ra, String senha) async {
    var url = Uri.parse("$api/saldo");
    final encodedBody = json.encode({"ra": ra, "senha": senha});

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: encodedBody);

    if (kDebugMode) {
      print("Requisição de Saldo");
      print(encodedBody);
      print(response.body);
      print(response.statusCode);
    }

    if (response.statusCode == 404 || response.statusCode == 401) {
      throw HttpException(response.body);
    }

    final parsed = jsonDecode(response.body);
    return "R\$ ${parsed['saldo']}";
  }

  static Future<bool> isFeriado(DateTime data) async {
    var date = DateFormat("yyyy-MM-dd").format(data);
    var url = Uri.parse("$api/date/feriado/$date");
    final response = await http.get(url);

    if (kDebugMode) {
      print(url);
      print(response.body);
    }

    var res = jsonDecode(response.body) as bool;
    return res;
  }
}
