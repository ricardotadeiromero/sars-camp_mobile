import 'package:dio/dio.dart';

class Api {
  static String url = "http://localhost:3000/";
  static String cardapioWeek = "cardapio/semana";
  static String cardapioByWeek = "cardapio/semana/";
  static String login = "aluno/login";
  static String saldo = "saldo";
}
  final api = Dio(BaseOptions(baseUrl: Api.url));
