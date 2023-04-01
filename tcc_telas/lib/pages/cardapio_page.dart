import 'dart:ui';
import '../controller/date_controller.dart';
import '../controller/cardapio_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class cardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<cardapioPage> {
  late DateTime selectedDay;
  var controller = CardapioController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFA12E2F),
              leading: IconButton(
                icon: Image.asset('image/logo.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              leadingWidth: 80,
              title: Text(
                'SARsCamp',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              titleSpacing: 0,
              actions: [
                SizedBox(
                  width: 50, // largura do espaço em pixels
                  child: IconButton(
                    icon: Icon(
                      Icons.star,
                      size: 40,
                    ),
                    onPressed: () {
                      // função chamada quando o ícone de estrela é pressionado
                    },
                  ),
                ),
                SizedBox(
                  width: 50, // largura do espaço em pixels
                  child: IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 40,
                    ),
                    onPressed: () {
                      // função chamada quando o ícone de informações é pressionado
                    },
                  ),
                ),
              ],
              bottom: TabBar(
                  indicatorColor: Color.fromARGB(255, 15, 142, 147),
                  tabs: [
                    Tab(
                        text: DateFormat("dd/MM")
                            .format(DiaDaSemana.obterData(DateTime.monday))),
                    Tab(
                        text: DateFormat("dd/MM")
                            .format(DiaDaSemana.obterData(DateTime.tuesday))),
                    Tab(
                        text: DateFormat("dd/MM")
                            .format(DiaDaSemana.obterData(DateTime.wednesday))),
                    Tab(
                        text: DateFormat("dd/MM")
                            .format(DiaDaSemana.obterData(DateTime.thursday))),
                    Tab(
                        text: DateFormat("dd/MM")
                            .format(DiaDaSemana.obterData(DateTime.friday))),
                  ],
                  onTap: (index) {
                    setState(() {
                      switch (index) {
                        case 0:
                          selectedDay = DiaDaSemana.obterData(DateTime.monday);
                          break;
                        case 1:
                          selectedDay = DiaDaSemana.obterData(DateTime.tuesday);
                          break;
                        case 2:
                          selectedDay =
                              DiaDaSemana.obterData(DateTime.wednesday);
                          break;
                        case 3:
                          selectedDay =
                              DiaDaSemana.obterData(DateTime.thursday);
                          break;
                        case 4:
                          selectedDay = DiaDaSemana.obterData(DateTime.friday);
                          break;
                      }
                    });
                  }),
            ),
            body: Stack(
              children: [
                Container(
                  color: Color(0xFF0A6066),
                  width: double.infinity,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        child: Opacity(
                          opacity: 0.12,
                          child: Image.asset('image/Unicamp.png'),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.sunny_snowing),
                          title: Text(
                            'Café da manhã',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.sunny),
                          title: Text(
                            'Almoço',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          subtitle: Text('Comum'),
                        ),
                        ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.sunny),
                          title: Text(
                            'Almoço',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          subtitle: Text('vegano'),
                        ),
                        ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.nightlight),
                          title: Text(
                            'Jantar',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          subtitle: Text('Comum'),
                        ),
                        ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.nightlight),
                          title: Text(
                            'Jantar',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          subtitle: Text('vegano'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
