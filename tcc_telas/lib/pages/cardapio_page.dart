import 'package:tcc_telas/pages/Componentes/background.dart';
import 'package:tcc_telas/pages/Componentes/cardapioPage.dart';
import 'dart:core';
import '../controller/date_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../model/cardapio.dart';
import '../connection/connection.dart';

class CardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<CardapioPage>
    with SingleTickerProviderStateMixin {
  late DateTime selectedDay;
  late List<CardapioBodyPage> bodyPage;
  var _indice = 0;
  late TabController _controller;
  late List<bool> verificaFeriado;
  int monday = DateTime.monday;
  int tuesday= DateTime.tuesday;
  int wednesday= DateTime.wednesday;
  int thursday = DateTime.thursday;
  int friday = DateTime.friday;

  Future<bool> checkFeriado(int date) async {
    final isFeriado = await Connection.getFeriado(date);
    if (isFeriado) {
      return true;
    } else
      return false;
  }

  void defineFeriado() async {
    verificaFeriado = [
      await checkFeriado(monday),
      await checkFeriado(tuesday),
      await checkFeriado(wednesday),
      await checkFeriado(thursday),
      await checkFeriado(friday),
    ];
  }

  @override
  void initState() {
    bodyPage = [
      CardapioBodyPage(selectedDayWeek: monday),
      CardapioBodyPage(selectedDayWeek: tuesday),
      CardapioBodyPage(selectedDayWeek: wednesday),
      CardapioBodyPage(selectedDayWeek: thursday),
      CardapioBodyPage(selectedDayWeek: friday),
    ];
    _controller = TabController(
        length: 5, vsync: this, initialIndex: DiaDaSemana.numberWeek());
    selectedDay = DateTime.now();
    _indice = DiaDaSemana.numberWeek();
    defineFeriado();
    setDay();
    super.initState();
  }

  void setDay() async {
    if (await checkFeriado(monday)) {
      _controller.index = 1;
      _indice = 1;
    }
    if (await checkFeriado(tuesday)) {
      _controller.index = 0;
      _indice = 0;
    }
    if (await checkFeriado(wednesday)) {
      _controller.index = 1;
      _indice = 1;
    }
    if (await checkFeriado(thursday)) {
      _controller.index = 2;
      _indice = 2;
    }
    if (await checkFeriado(friday)) {
      _controller.index = 3;
      _indice = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          shouldPopOnLogoPressed: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TabBar(
                controller: _controller,
                isScrollable: false,
                indicatorColor: const Color.fromARGB(255, 15, 142, 147),
                tabs: [
                  MyTab(date: monday),
                  MyTab(date: tuesday),
                  MyTab(date: wednesday),
                  MyTab(date: thursday),
                  MyTab(date: friday),
                ],
                onTap: (index) {
                  if (verificaFeriado[0] && index == 0) {
                    _controller.index = _controller.previousIndex;
                    _indice = _controller.previousIndex;
                  }
                  if (verificaFeriado[1] && index == 1) {
                    _controller.index = _controller.previousIndex;
                    _indice = _controller.previousIndex;
                  }
                  if (verificaFeriado[2] && index == 2) {
                    _controller.index = _controller.previousIndex;
                    _indice = _controller.previousIndex;
                  }
                  if (verificaFeriado[3] && index == 3) {
                    _controller.index = _controller.previousIndex;
                    _indice = _controller.previousIndex;
                  }
                  if (verificaFeriado[4] && index == 4) {
                    _controller.index = _controller.previousIndex;
                    _indice = _controller.previousIndex;
                  }
                  setState(() {
                    _indice = index;
                  });
                }),
          ),
        ),
        body: Background(
          components: Container(
            alignment: AlignmentDirectional.topStart,
            child: SingleChildScrollView(child: bodyPage[_indice]),
          ),
        ));
  }
}

class CardapioBodyPage extends StatelessWidget {
  late Future<List<Cardapio>> future;
  late int selectedDayWeek;

  CardapioBodyPage({Key? key, required this.selectedDayWeek})
      : super(key: key) {
    var selectedDay = DiaDaSemana.obterData(selectedDayWeek);
    future =
        Connection.getCardapio(DateFormat("yyyy-MM-dd").format(selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionWidgetCafe(
            leadingIcon: const Icon(Icons.sunny_snowing),
            titleText: 'Café da manhã',
            future: MyListViewCafe()),
        ExpansionWidget(
            leadingIcon: const Icon(Icons.sunny),
            titleText: 'Almoço',
            subtitleText: 'Comum',
            future: CustomFutureBuilder<List<Cardapio>>(
              future: future,
              periodo: 0,
              vegetariano: 0,
            )),
        ExpansionWidget(
            leadingIcon: const Icon(Icons.sunny),
            titleText: 'Almoço',
            subtitleText: 'Vegetariano',
            future: CustomFutureBuilder<List<Cardapio>>(
              future: future,
              periodo: 0,
              vegetariano: 1,
            )),
        ExpansionWidget(
            leadingIcon: const Icon(Icons.nightlight),
            titleText: 'Jantar',
            subtitleText: 'Comum',
            future: CustomFutureBuilder<List<Cardapio>>(
              future: future,
              periodo: 1,
              vegetariano: 0,
            )),
        ExpansionWidget(
            leadingIcon: const Icon(Icons.nightlight),
            titleText: 'Jantar',
            subtitleText: 'Vegetariano',
            future: CustomFutureBuilder<List<Cardapio>>(
              future: future,
              periodo: 1,
              vegetariano: 1,
            )),
      ],
    );
  }
}
