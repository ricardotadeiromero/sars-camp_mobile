import 'dart:convert';
import 'package:TCC/configs/style.dart';
import 'package:flutter/foundation.dart';
import 'package:TCC/pages/componentes/cardapioPage.dart';
import 'package:TCC/pages/componentes/background.dart';
import 'dart:core';
import '../controller/date_controller.dart';
import 'package:flutter/material.dart';
import '../model/cardapio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connection/connection.dart';

int qntDias(List<dynamic> list) {
  int count = 0;
  for (var dia in list) {
    if (dia != null && dia != "feriado") {
      count++;
    }
  }
  return count;
}

Future<List<dynamic>?> cardapio() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final result = await Connection.getCardapio();
    if (result != null) {
      await prefs.setString('card', json.encode(result));
    }
    return result;
  } catch (e) {
    var errorJson = prefs.getString('card');
    if (errorJson != null) {
      return json.decode(errorJson);
    }
    return null;
  }
}

List<List<Cardapio>> filtraDias(List<dynamic> list) {
  List<List<Cardapio>> filtrada = [];

  for (var dia in list) {
    if (dia != null && dia != "feriado") {
      List<Cardapio> cardapiosDia = [];
      for (var cardapio in dia) {
        cardapiosDia.add(Cardapio.fromMap(cardapio));
      }
      filtrada.add(cardapiosDia);
    }
  }
  if (kDebugMode) {
    print("foronfon");
    print(filtrada);
  }

  return filtrada;
}

int numberWeek(List<List<Cardapio>> list) {
  //calculo do initial index;
  int mday = 0;
  for (var card in list) {
    print('fonfifon');
    print(DateTime.now().day);
    if (list.indexOf(card) > mday) {
      mday = list.indexOf(card);
      if (card[0].data.day > DateTime.now().day &&
          card[0].data.month == DateTime.now().month) {
        return list.indexOf(card);
      }
      if (card[0].data.day == DateTime.now().day &&
          card[0].data.month == DateTime.now().month) {
        return list.indexOf(card);
      }
    }
  }
  return mday;
}

class CardapioPage extends StatefulWidget {
  const CardapioPage({super.key});

  @override
  State<CardapioPage> createState() => _CardapioPage();
}

class _CardapioPage extends State<CardapioPage>
    with SingleTickerProviderStateMixin {
  late DateTime selectedDay;
  late List<SingleChildScrollView> bodyPage;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cardapio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage(type: true);
          } else if (snapshot.hasData) {
            final lista = snapshot.data!;
            final listaFiltrada = filtraDias(lista);
            final initial = numberWeek(listaFiltrada);
            _controller = TabController(
                length: listaFiltrada.length,
                vsync: this,
                initialIndex: initial);
            return Scaffold(
                appBar: MyAppBar(
                  shouldPopOnLogoPressed: true,
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: TabBar(
                        controller: _controller,
                        isScrollable: false,
                        indicatorColor: myAquaGreen,
                        tabs: listaFiltrada
                            .map((e) => CardapiosDiaTab(date: e[0].data))
                            .toList(),
                      )),
                ),
                body: Background(
                  components: Container(
                      alignment: AlignmentDirectional.topStart,
                      child: TabBarView(
                        //physics: ClampingScrollPhysics(),
                        controller: _controller,
                        children: listaFiltrada
                            .map((cardapios) =>
                                CardapioBodyPage(cardapios: cardapios))
                            .toList(),
                      )),
                ));
          } else {
            return const LoadingPage(type: false);
          }
        });
  }
}

/// Tela de cardápios de um dia específico

