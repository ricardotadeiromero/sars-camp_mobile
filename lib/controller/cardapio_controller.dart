import 'dart:io';

import 'package:TCC/model/Cardapio.dart';
import 'package:TCC/repositories/cardapio_repository.dart';
import 'package:TCC/service/prefs_cardapio.dart';

class CardapioController {
  final ICardapioRepository repository;
  final PrefsCardapio prefsCardapio;

  CardapioController(this.repository, this.prefsCardapio);

  List<List<Cardapio>> agroup(List<dynamic> response) {
    List<List<Cardapio>> typed = [];
    for (var cardapios in response) {
      List<Cardapio> cardapioTyped = [];
      for (var cardapio in cardapios) {
        cardapioTyped.add(Cardapio.fromMap(cardapio));
      }
      typed.add(cardapioTyped);
    }
    return typed;
  }

  Future<List<List<Cardapio>>> findWeek() async {
    try {
      final response = await repository.findWeek();
      await prefsCardapio.save(response);

      return agroup(response);
    } catch (e) {
      print(e);
      if (e is HttpException) {
        rethrow;
      }
      final response = await prefsCardapio.get();
      if (response != null) {
        return agroup(response);
      }
      rethrow;
    }
  }

  Future<List<List<Cardapio>>> findByWeek(int week) async {
    try {
      final response = await repository.findByWeek(week);
      print("fooooooooon");
      await prefsCardapio.save(response);
      return agroup(response);
    } catch (e) {
      print(e);
      if (e is HttpException) {
        rethrow;
      }
      final response = await prefsCardapio.get();
      if (response != null) {
        return agroup(response);
      }
      rethrow;
    }
  }
}
