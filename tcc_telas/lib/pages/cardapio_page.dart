import 'package:tcc_telas/pages/Componentes/Background.dart';
import 'package:tcc_telas/pages/Componentes/CardapioPage.dart';
import 'dart:core';
import '../controller/date_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../model/Cardapio.dart';
import '../connection/connection.dart';

class cardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<cardapioPage>
    with SingleTickerProviderStateMixin {
  late DateTime selectedDay;
  late List<CardapioBodyPage> bodyPage;
  var _indice = 0;
  late TabController _controller;
  late List<bool> fon;

  Future<bool> checkFeriado(int date) async {
    final isFeriado = await Connection.getFeriado(date);
    if (isFeriado) {
      return true;
    } else
      return false;
  }

  void fonfi()async {
    fon = [
      await checkFeriado(DateTime.monday),
      await checkFeriado(DateTime.tuesday),
      await checkFeriado(DateTime.wednesday),
      await checkFeriado(DateTime.thursday),
      await checkFeriado(DateTime.friday),
    ];
  }


  @override
  void initState() {
    bodyPage = [
      CardapioBodyPage(selectedDayWeek: DateTime.monday),
      CardapioBodyPage(selectedDayWeek: DateTime.tuesday),
      CardapioBodyPage(selectedDayWeek: DateTime.wednesday),
      CardapioBodyPage(selectedDayWeek: DateTime.thursday),
      CardapioBodyPage(selectedDayWeek: DateTime.friday),
    ];
    _controller = TabController(length: 5, vsync: this, initialIndex: DiaDaSemana.numberWeek());
    selectedDay = DateTime.now();
    fonfi();
    setDay();
    super.initState();
  }

  void setDay() async{
    if(await checkFeriado(DateTime.monday)){
                        _controller.index = 1;
                      }
                      if(await checkFeriado(DateTime.tuesday)){
                        _controller.index = 0;
                      }
                      if(await checkFeriado(DateTime.thursday)){
                        _controller.index = 1;
                      }
                      if(await checkFeriado(DateTime.wednesday)){
                        _controller.index = 2;
                      }
                      if(await checkFeriado(DateTime.friday)){
                        _controller.index = 3;
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
                      Tab(
                        child: FutureBuilder<bool>(
                          future: Connection.getFeriado(DateTime.monday),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!
                                  ? 'Feriado'
                                  : DateFormat("dd/MM").format(
                                      DiaDaSemana.obterData(DateTime.monday)));
                            } else if (snapshot.hasError) {
                              return const Text('Erro ao carregar');
                            } else {
                              return const MyProgressIndicator();
                            }
                          },
                        ),
                      ),
                      Tab(
                          child: FutureBuilder<bool>(
                        future: Connection.getFeriado(DateTime.tuesday),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!
                                ? 'Feriado'
                                : DateFormat("dd/MM").format(
                                    DiaDaSemana.obterData(DateTime.tuesday)));
                          } else if (snapshot.hasError) {
                            return const Text('Erro ao carregar');
                          } else {
                            return const MyProgressIndicator();
                          }
                        },
                      )),
                      Tab(
                        child: FutureBuilder<bool>(
                          future: Connection.getFeriado(DateTime.wednesday),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!
                                  ? 'Feriado'
                                  : DateFormat("dd/MM").format(
                                      DiaDaSemana.obterData(
                                          DateTime.wednesday)));
                            } else if (snapshot.hasError) {
                              return const Text('Erro ao carregar');
                            } else {
                              return const MyProgressIndicator();
                            }
                          },
                        ),
                      ),
                      Tab(
                        child: FutureBuilder<bool>(
                          future: Connection.getFeriado(DateTime.thursday),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!
                                  ? 'Feriado'
                                  : DateFormat("dd/MM").format(
                                      DiaDaSemana.obterData(
                                          DateTime.thursday)));
                            } else if (snapshot.hasError) {
                              return const Text('Erro ao carregar');
                            } else {
                              return const MyProgressIndicator();
                            }
                          },
                        ),
                      ),
                      Tab(
                        child: FutureBuilder<bool>(
                          future: Connection.getFeriado(DateTime.friday),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!
                                  ? 'Feriado'
                                  : DateFormat("dd/MM").format(
                                      DiaDaSemana.obterData(DateTime.friday)));
                            } else if (snapshot.hasError) {
                              return const Text('Erro ao carregar');
                            } else {
                              return const MyProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ],
                    onTap: (index) {
                      if(fon[0]){
                        _controller.index = 1;
                      }
                      if(fon[1]){
                        _controller.index = 0;
                      }
                      if(fon[2]){
                        _controller.index = 1;
                      }
                      if(fon[3]){
                        _controller.index = 2;
                      }
                      if(fon[4]){
                        _controller.index = 3;
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
                child: SingleChildScrollView(
                  child: bodyPage[_indice]
                ),
              ),
            ));
  }
}

class CardapioBodyPage extends StatelessWidget {
   late Future<List<Cardapio>> future;
  late int selectedDayWeek;

  CardapioBodyPage({Key? key, required this.selectedDayWeek}) : super(key: key) {
    var selectedDay = DiaDaSemana.obterData(selectedDayWeek);
    future = Connection.getCardapio(
        DateFormat("yyyy-MM-dd").format(selectedDay));
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