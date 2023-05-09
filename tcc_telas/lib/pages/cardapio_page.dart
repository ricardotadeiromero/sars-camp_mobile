import 'package:tcc_telas/pages/Componentes/Background.dart';
import 'package:tcc_telas/pages/Componentes/CardapioPage.dart';

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
  late Future<List<Cardapio>> _future;
  var index = DateTime.now().weekday - 1;

  Future<bool> checkFeriado(int date) async {
    final isFeriado = await Connection.getFeriado(date);
    if (isFeriado) {
      return true;
    } else
      return false;
  }

  @override
  void initState() {
    selectedDay = DateTime.now();
    _future =
        Connection.getCardapio(DateFormat("yyyy-MM-dd").format(selectedDay));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: DiaDaSemana.numberWeek(),
        length: 5,
        child: Scaffold(
            appBar: MyAppBar(
              shouldPopOnLogoPressed: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: TabBar(
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
                      setState(() async {
                        switch (index) {
                          case 0:
                            if (await checkFeriado(DateTime.monday)) {
                              return;
                            } else {
                              selectedDay =
                                  DiaDaSemana.obterData(DateTime.monday);
                              _future = Connection.getCardapio(
                                  DateFormat("yyyy-MM-dd").format(selectedDay));
                              break;
                            }

                          case 1:
                            selectedDay =
                                DiaDaSemana.obterData(DateTime.tuesday);
                            _future = Connection.getCardapio(
                                DateFormat("yyyy-MM-dd").format(selectedDay));
                            break;
                          case 2:
                            selectedDay =
                                DiaDaSemana.obterData(DateTime.wednesday);
                            _future = Connection.getCardapio(
                                DateFormat("yyyy-MM-dd").format(selectedDay));
                            break;
                          case 3:
                            selectedDay =
                                DiaDaSemana.obterData(DateTime.thursday);
                            _future = Connection.getCardapio(
                                DateFormat("yyyy-MM-dd").format(selectedDay));
                            break;
                          case 4:
                            selectedDay =
                                DiaDaSemana.obterData(DateTime.friday);
                            _future = Connection.getCardapio(
                                DateFormat("yyyy-MM-dd").format(selectedDay));
                            break;
                        }
                      });
                    }),
              ),
            ),
            body: Background(
              components: Container(
                alignment: AlignmentDirectional.topStart,
                child: SingleChildScrollView(
                  child: Column(
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
                            future: _future,
                            periodo: 0,
                            vegetariano: 0,
                          )),
                      ExpansionWidget(
                          leadingIcon: const Icon(Icons.sunny),
                          titleText: 'Almoço',
                          subtitleText: 'Vegetariano',
                          future: CustomFutureBuilder<List<Cardapio>>(
                            future: _future,
                            periodo: 0,
                            vegetariano: 1,
                          )),
                      ExpansionWidget(
                          leadingIcon: const Icon(Icons.nightlight),
                          titleText: 'Jantar',
                          subtitleText: 'Comum',
                          future: CustomFutureBuilder<List<Cardapio>>(
                            future: _future,
                            periodo: 1,
                            vegetariano: 0,
                          )),
                      ExpansionWidget(
                          leadingIcon: const Icon(Icons.nightlight),
                          titleText: 'Jantar',
                          subtitleText: 'Vegetariano',
                          future: CustomFutureBuilder<List<Cardapio>>(
                            future: _future,
                            periodo: 1,
                            vegetariano: 1,
                          )),
                    ],
                  ),
                ),
              ),
            )));
  }
}
