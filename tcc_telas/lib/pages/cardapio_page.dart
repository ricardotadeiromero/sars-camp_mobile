import 'package:tcc_telas/pages/Componentes/CardapioPage.dart';
import 'package:tcc_telas/pages/Componentes/background.dart';
import 'dart:core';
import '../controller/date_controller.dart';
import 'package:intl/intl.dart';
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

List<dynamic> filtraDias(List<dynamic> list) {
  List<dynamic> filtrada = [];
  for (var dia in list) {
    if (dia != null && dia != "feriado") {
      filtrada.add(dia);
    }
  }
  print("foronfon");
  print(filtrada);
  return filtrada;
}

class CardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<CardapioPage>
    with SingleTickerProviderStateMixin {
  late DateTime selectedDay;
  late List<SingleChildScrollView> bodyPage;
  var _indice = 0;
  late TabController _controller;
  late List<bool> verificaFeriado;
  late Future future;
  DateTime monday = DiaDaSemana.obterData(DateTime.monday);
  DateTime tuesday = DiaDaSemana.obterData(DateTime.tuesday);
  DateTime wednesday = DiaDaSemana.obterData(DateTime.wednesday);
  DateTime thursday = DiaDaSemana.obterData(DateTime.thursday);
  DateTime friday = DiaDaSemana.obterData(DateTime.friday);

  Future<bool> checkFeriado(DateTime date) async {
    final isFeriado = await Connection.getFeriado(date);
    if (isFeriado) {
      return true;
    } else
      return false;
  }

  Future<void> defineFeriado() async {
    verificaFeriado = await Future.wait([
      checkFeriado(monday),
      checkFeriado(tuesday),
      checkFeriado(wednesday),
      checkFeriado(thursday),
      checkFeriado(friday),
    ]);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> setDay() async {
    //eu mato quem apagar essa poha
    print(verificaFeriado[0]);
    if (verificaFeriado[0] && _controller.index == 0) {
      _controller.index = 1;
    }
    if (verificaFeriado[1] && _controller.index == 1) {
      _controller.index = 0;
    }
    if (verificaFeriado[2] && _controller.index == 2) {
      _controller.index = 1;
    }
    if (verificaFeriado[3] && _controller.index == 3) {
      _controller.index = 2;
    }
    if (verificaFeriado[4] && _controller.index == 4) {
      _controller.index = 3;
    }
  }

  Future<void> setDay2() async {
    //eu mato quem apagar essa poha
    await () async {};
    if (verificaFeriado[0] && _controller.index == 0) {
      _controller.index = _controller.previousIndex;
    }
    if (verificaFeriado[1] && _controller.index == 1) {
      _controller.index = _controller.previousIndex;
    }
    if (verificaFeriado[2] && _controller.index == 2) {
      _controller.index = _controller.previousIndex;
    }
    if (verificaFeriado[3] && _controller.index == 3) {
      _controller.index = _controller.previousIndex;
    }
    if (verificaFeriado[4] && _controller.index == 4) {
      _controller.index = _controller.previousIndex;
    }
  }

  void fon() async {
    await defineFeriado();
    print(verificaFeriado);
    await setDay();
    _controller.addListener(setDay2);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Connection.getCardapio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage(
              type: true,
            );
          } else if (snapshot.hasData) {
            final lista = snapshot.data!;
            final listaFiltrada = filtraDias(lista);
            _controller =
                TabController(length: listaFiltrada.length, vsync: this);
            return Scaffold(
                appBar: MyAppBar(
                  shouldPopOnLogoPressed: true,
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: TabBar(
                        controller: _controller,
                        isScrollable: false,
                        indicatorColor: const Color.fromARGB(255, 15, 142, 147),
                        tabs: listaFiltrada.map((e) {
                          var car = (e as List)
                              .map((fon) => Cardapio.fromMap(fon))
                              .toList();
                          return MyTab(date: car[0].data);
                        }).toList(),
                      )),
                ),
                body: Background(
                  components: Container(
                      alignment: AlignmentDirectional.topStart,
                      child: TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
                        controller: _controller,
                        children: listaFiltrada
                            .map((res) => CardapioBodyPage(req: res))
                            .toList(),
                      )),
                ));
          } else {
            return LoadingPage(type: false);
          }
        });
  }
}

class CardapioBodyPage extends StatelessWidget {
  dynamic req;
  CardapioBodyPage({Key? key, required this.req}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (req == "feriado") {
      return Text("Feriado");
    }
    if (req != null) {
      return SingleChildScrollView(
        child: MyExpansionPanel(
            cardapios: req.map((cardapio) {
          return Cardapio.fromMap(cardapio);
        }).toList()),
      );
    }
    return Text("Cardápio indisponível");
  }
}
