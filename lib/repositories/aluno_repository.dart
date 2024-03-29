import 'package:sarscamp/configs/api.dart';
import 'package:sarscamp/model/aluno.dart';
import 'package:sarscamp/model/error.dart';
import 'package:sarscamp/model/saldo.dart';
import 'package:dio/dio.dart';

abstract class IAlunoRepository {
  Future<String> login(Aluno aluno);
  Future<Saldo> saldo(String token);
}

class AlunoRepository implements IAlunoRepository {
  @override
  Future<String> login(Aluno aluno) async {
    try {
      final response =
          await api.post(Api.login, data: aluno.toMap(), options: Options());
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          throw const FonError('Senha inválida!');
        }
        if (e.response!.statusCode == 404) {
          throw const FonError('RA inválido!');
        }
      }
      throw const FonError('Erro ao consultar aluno');
    }
  }

  @override
  Future<Saldo> saldo(String token) async {
    try {
      final response = await api.get(Api.saldo,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
      final saldo = Saldo.fromMap(response.data);
      print(saldo);
      return saldo;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          throw Exception(e);
        }
      }
      throw const FonError('Erro ao consultar saldo!');
    }
  }
}
