import 'package:flutter/foundation.dart';

class Cardapio {
  DateTime data;
  String principal;
  String guarnicao;
  String salada;
  String sobremesa;
  String suco;
  int periodo;
  int vegetariano;

  Cardapio(
      {required this.data,
      required this.principal,
      required this.guarnicao,
      required this.salada,
      required this.sobremesa,
      required this.suco,
      required this.periodo,
      required this.vegetariano});

  factory Cardapio.fromMap(dynamic map) {
    if (kDebugMode) {
      print("fromMap");
      print(map);
      print(map.runtimeType);
    }

    return Cardapio(
        data: DateTime.parse(map["data"]),
        principal: map["principal"] ?? "",
        guarnicao: map["guarnicao"] ?? "",
        salada: map["salada"] ?? "",
        sobremesa: map["sobremesa"] ?? "",
        suco: map["suco"] ?? "",
        periodo: map["periodo"] ?? 0,
        vegetariano: map["vegetariano"] ?? 0);
  }
}
