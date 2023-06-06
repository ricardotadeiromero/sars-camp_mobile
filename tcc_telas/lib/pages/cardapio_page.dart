import 'package:tcc_telas/pages/Componentes/CardapioPage.dart';
import 'package:tcc_telas/pages/Componentes/background.dart';
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
  late List<SingleChildScrollView> bodyPage;
  var _indice = 0;
  late TabController _controller;
  late List<bool> verificaFeriado;
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
    bodyPage = [

      SingleChildScrollView(
        child: CardapioBodyPage(selectedDayWeek: monday),
      ),
      SingleChildScrollView(
        child: CardapioBodyPage(selectedDayWeek: tuesday),
      ),
      SingleChildScrollView(
        child: CardapioBodyPage(selectedDayWeek: wednesday),
      ),
      SingleChildScrollView(
        child: CardapioBodyPage(selectedDayWeek: thursday),
      ),
      SingleChildScrollView(
        child: CardapioBodyPage(selectedDayWeek: friday),
      ),
      
    ];
    _controller = TabController(
        length: 5, vsync: this, initialIndex: DiaDaSemana.numberWeek());
    selectedDay = DateTime.now();
    _indice = DiaDaSemana.numberWeek();
    print(thursday);
    fon();
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
            ),
          ),
        ),
        body: 
        Background(
          components: Container(
            alignment: AlignmentDirectional.topStart,
            child: TabBarView(
              //physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: bodyPage,
            ),
          ),
          )
          
        );
  }
}

class CardapioBodyPage extends StatelessWidget {
  late Future<List<Cardapio>> future;
  late DateTime selectedDayWeek;

  CardapioBodyPage({Key? key, required this.selectedDayWeek})
      : super(key: key) {
    var selectedDay = selectedDayWeek;
    future =
        Connection.getCardapio(DateFormat("yyyy-MM-dd").format(selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [MyExpansionPanel(future: future)],
    );
  }
}
