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
      final response = await api.get(Api.achadosPerdidos);
      final data = response.data.map((e) => Perdido.fromMap(e)).toList();
      return data;
    } on DioException catch(e) {
      if(e.response!=null){
        if(e.response!.statusCode==404){
          throw const FonError('Nenhum item encontrado!');
        }
      }
      throw const FonError('Erro ao consultar itens');
    }
  }
}
