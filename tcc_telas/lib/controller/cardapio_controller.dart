import '../model/Cardapio.dart';

class CardapioController {
  late List<Cardapio> Cardap;

  CardapioController() {
    Cardap = [
      Cardapio(aj: 0, vn: 0),
      Cardapio(aj: 1, vn: 1),
      Cardapio(aj: 1, vn: 0),
      Cardapio(aj: 2, vn: 1),
      Cardapio(aj: 2, vn: 0),
    ];
  }
}