import 'package:TCC/configs/api.dart';
import 'package:TCC/model/aluno.dart';
import 'package:dio/dio.dart';

abstract class IAlunoRepository {
  Future<String> login(Aluno aluno);
  Future<double> saldo(String token);
}

class AlunoRepository implements IAlunoRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: Api.url));

  @override
  Future<String> login(Aluno aluno) async {
    try {
      final response = await dio.post(Api.login, data: aluno);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<double> saldo(String token) async {
    try {
      final response = await dio.get(Api.saldo, options: Options(headers: {"access_token": token}));
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  } 
}
