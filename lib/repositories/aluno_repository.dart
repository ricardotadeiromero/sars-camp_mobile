import 'package:TCC/configs/api.dart';
import 'package:TCC/model/aluno.dart';
import 'package:TCC/model/error.dart';
import 'package:TCC/model/saldo.dart';
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
          throw const FonError('Token inválido!');
        }
      }
      throw const FonError('Erro ao consultar saldo!');
    }
  }
}
