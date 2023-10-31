import 'package:TCC/configs/api.dart';
import 'package:TCC/model/error.dart';
import 'package:TCC/model/perdido.dart';
import 'package:dio/dio.dart';

abstract class IAchadosPerdidosRepository {
  Future<List<Perdido>> finalAll();
}

class AchadosPerdidosRepository implements IAchadosPerdidosRepository {
  @override
  Future<List<Perdido>> finalAll() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await api.get(Api.achadosPerdidos);
      print(response);
      List<Perdido> data = [];
      for (var json in (response.data as List)) {
        data.add(Perdido.fromMap(json));
      }
      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw const FonError('Nenhum item encontrado!');
        }
      }
      throw const FonError('Erro ao consultar itens');
    }
  }
}
