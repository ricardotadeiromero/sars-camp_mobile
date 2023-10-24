import 'package:TCC/configs/api.dart';
import 'package:TCC/model/aluno.dart';
import 'package:dio/dio.dart';

abstract class IAlunoRepository {
  Future<String> login(Aluno aluno);
  Future<String> saldo(String token);
}

class AlunoRepository implements IAlunoRepository {

  @override
  Future<String> login(Aluno aluno) async {
    try {
      final response = await api.post(Api.login, data: aluno.toMap(), options: Options());
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> saldo(String token) async {
    try {
      final response = await api.get(Api.saldo, options: Options(headers: {"Authorization": "Bearer $token"}));
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  } 
}
