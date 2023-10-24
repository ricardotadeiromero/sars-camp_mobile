import 'dart:io';

import 'package:TCC/configs/api.dart';
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
          throw const HttpException('Cardápio indisponível!');
        } else {
          throw Exception('Falha ao carregar cardápio');
        }
      }
      throw Exception('Falha ao carregar cardápio');
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
          throw const HttpException('Cardápio indisponível!');
        } else {
          throw Exception('Falha ao carregar cardápio');
        }
      }
      throw Exception('Falha ao carregar cardápio');
    }
  }
}
