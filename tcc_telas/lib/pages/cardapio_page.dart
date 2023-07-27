import 'package:flutter/foundation.dart';
import 'package:tcc_telas/pages/Componentes/CardapioPage.dart';
import 'package:tcc_telas/pages/Componentes/Background.dart';
import 'dart:core';
import '../controller/date_controller.dart';
import 'package:flutter/material.dart';
import '../model/Cardapio.dart';
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

int numberWeek(List<List<Cardapio>> list, int dayWeek) {
  //calculo do initial index;
  int mday = 0;
  for (var card in list) {
    print(card[0].data.weekday);
    if (card[0].data.weekday == dayWeek) {
      mday = list.indexOf(card);
    } else if (card[0].data.weekday > dayWeek) {
      mday = list.indexOf(card);
    } else if (list.indexOf(card) > mday) {
      mday = list.indexOf(card);
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
        future: Connection.getCardapio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage(type: true);
          } else if (snapshot.hasData) {
            final lista = snapshot.data!;
            final listaFiltrada = filtraDias(lista);
            final initial = numberWeek(listaFiltrada, DiaDaSemana.numberWeek());
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
                        indicatorColor: const Color.fromARGB(255, 15, 142, 147),
                        tabs: listaFiltrada
                            .map((e) => CardapiosDiaTab(date: e[0].data))
                            .toList(),
                      )),
                ),
                body: Background(
                  components: Container(
                      alignment: AlignmentDirectional.topStart,
                      child: TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
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
class CardapioBodyPage extends StatelessWidget {
  final List<Cardapio> cardapios;
  const CardapioBodyPage({Key? key, required this.cardapios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CardapiosDiaPanel(cardapios: cardapios),
    );
  }
}
