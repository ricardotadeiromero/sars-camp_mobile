import 'package:TCC/model/perdido.dart';
import 'package:TCC/repositories/achados_perdidos_repository.dart';

class AchadosPerdidosController {
  IAchadosPerdidosRepository repository;
  AchadosPerdidosController(this.repository);

  Future<List<Perdido>> findAll() async {
    try {
      final response = await repository.finalAll();
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
