import 'package:TCC/configs/api.dart';
import 'package:TCC/model/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ICardapioRepository {
  Future<List<dynamic>> findWeek();
  Future<List<dynamic>> findByWeek(int week);
}

class CardapioRepository implements ICardapioRepository {

  @override
  Future<List<dynamic>> findWeek() async {
    try {
      final response = await api.get(Api.cardapioWeek);
      if (kDebugMode) {
        print("fon");
        print(response);
      }
      await Future.delayed(const Duration(seconds: 1));
      final listCardapios = response.data;
      return listCardapios;
    } on DioException catch (e) {
      print(e.response);
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw const FonError('Cardápio indisponível!');
        } else {
          throw const FonError('Falha ao carregar cardápio');
        }
      }
      throw const FonError('Falha ao carregar cardápio');
    }
  }

  @override
  Future<List<dynamic>> findByWeek(int week) async {
    try {
      final response = await api.get(Api.cardapioByWeek + week.toString());
      if (kDebugMode) {
        print("fon");
        print(response);
      }
      await Future.delayed(const Duration(seconds: 1));
      final listCardapios = response.data;
      return listCardapios;
    } on DioException catch (e) {
      print(e.response);
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw const FonError('Cardápio indisponível!');
        } else {
          throw const FonError('Falha ao carregar cardápio');
        }
      }
      throw const FonError('Falha ao carregar cardápio');
    }
  }
}
