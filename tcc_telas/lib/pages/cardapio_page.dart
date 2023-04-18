import 'package:tcc_telas/pages/Componentes/Background.dart';
import 'package:tcc_telas/pages/Componentes/CardapioPage.dart';

import '../controller/date_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../model/Cardapio.dart';
import '../connection/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class cardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<cardapioPage> with SingleTickerProviderStateMixin{
  late DateTime selectedDay;
  late Future<List<Cardapio>> _future;

  @override
  void initState() {
    _future = Connection.getCardapio(DateFormat("yyyy-MM-dd")
        .format(DiaDaSemana.obterData(DateTime.monday)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: MyAppBar(
              shouldPopOnLogoPressed: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: TabBar(
                    indicatorColor: const Color.fromARGB(255, 15, 142, 147),
                    tabs: [
                      Tab(
                          text: DateFormat("dd/MM")
                              .format(DiaDaSemana.obterData(DateTime.monday))),
                      Tab(
                          text: DateFormat("dd/MM")
                              .format(DiaDaSemana.obterData(DateTime.tuesday))),
                      Tab(
                          text: DateFormat("dd/MM").format(
                              DiaDaSemana.obterData(DateTime.wednesday))),
                      Tab(
                          text: DateFormat("dd/MM").format(
                              DiaDaSemana.obterData(DateTime.thursday))),
                      Tab(
                          text: DateFormat("dd/MM")
                              .format(DiaDaSemana.obterData(DateTime.friday))),
                    ],
                    onTap: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            selectedDay =
                                DiaDaSemana.obterData(DateTime.monday);
                            _future = Connection.getCardapio(
                                DateFormat("yyyy-MM-dd").format(selectedDay));
                            break;
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
