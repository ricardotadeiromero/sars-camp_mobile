import 'dart:ui';
import '../controller/date_controller.dart';
import '../controller/cardapio_controller.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Cardapio.dart';
import '../connection/connection.dart';
import 'home_page.dart';

class cardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<cardapioPage> {
  late DateTime selectedDay;
  late Cardapio cardapioAN, cardapioAV, cardapioJN, cardapioJV;
  Future<List<Cardapio>>? _future;
  var controller = CardapioController();

  @override
  void initState() {
    _future = Connection.getCardapio(DiaDaSemana.obterData(DateTime.monday)).then((iterable) => iterable.toList());

    super.initState();
  }

  static Future<Iterable<Cardapio>> getCardapio(DateTime data) async {
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
      host: '143.106.241.3',
      port: 3306,
      user: 'cl201605',
      password: 'cl*20122005',
      db: 'cl201605',
    ));
    final results = await conn.query(
        "SELECT principal,guarnicao,salada,sobremesa,suco,periodo,vegetariano FROM Cardapio WHERE data = '${DateFormat("yyyy-MM-dd").format(data)}';");
    return results.map((row) => Cardapio.fromMap(row.fields));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFA12E2F),
              leading: IconButton(
                icon: Image.asset('image/logo.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              leadingWidth: 80,
              title: const Text(
                'SARsCamp',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              titleSpacing: 0,
              actions: [
                SizedBox(
                  width: 50, // largura do espaço em pixels
                  child: IconButton(
                    icon: const Icon(
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
                    icon: const Icon(
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
                  indicatorColor: const Color.fromARGB(255, 15, 142, 147),
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
                          _future = getCardapio(selectedDay).then((iterable) => iterable.toList());
                          break;
                        case 1:
                          selectedDay = DiaDaSemana.obterData(DateTime.tuesday);
                          _future = getCardapio(selectedDay).then((iterable) => iterable.toList());
                          break;
                        case 2:
                          selectedDay =
                              DiaDaSemana.obterData(DateTime.wednesday);
                              _future = getCardapio(selectedDay).then((iterable) => iterable.toList());
                          break;
                        case 3:
                          selectedDay =
                              DiaDaSemana.obterData(DateTime.thursday);
                              _future = getCardapio(selectedDay).then((iterable) => iterable.toList());
                          break;
                        case 4:
                          selectedDay = DiaDaSemana.obterData(DateTime.friday);
                          _future = getCardapio(selectedDay).then((iterable) => iterable.toList());
                          break;
                      }
                    });
                  }),
            ),
            body: Stack(
              children: [
                Container(
                  color: const Color(0xFF0A6066),
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
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                         children: [
                        const ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.sunny_snowing),
                          title: Text(
                            'Café da manhã',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white
                            ),
                          ),
                        ),
                        ExpansionTile(
                          iconColor: Color.fromARGB(159, 255, 255, 255),
                          textColor: Color.fromARGB(159, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 193, 54, 57),
                          leading: Icon(Icons.sunny),
                          title: const Text(
                            'Almoço',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white
                            ),
                          ),
                          subtitle: Text('Comum'),
                          children: <Widget>[
                            FutureBuilder<List<Cardapio>>(
                              future: _future,
                              builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if(snapshot.hasData){
                                final list = snapshot.data!;
                                if(list.isEmpty){
                                  return Text('Erro ao carregar os itens');
                                } else {
                                   var cardapio = null;
                                   for(var item in list){
                                     if(item.periodo == 1 && item.vegetariano == 0){
                                        cardapio = item;
                                      }
                                    }
                                   if(cardapio != null){
                                     return ListView(
                                      shrinkWrap: true,
                                       children: [
                                       ListTile(
                                          leading: const Text('Principal: ',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 255, 255, 255)),),
                                          title: Text(cardapio.principal,style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color.fromARGB(157, 255, 255, 255))),
                                        ),
                                        ListTile(
                                          leading: const Text('Guarnição: ',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 255, 255, 255)),),
                                          title: Text(cardapio.guarnicao,style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color.fromARGB(157, 255, 255, 255))),
                                        ),
                                        ListTile(
                                          leading: const Text('Salada: ',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 255, 255, 255)),),
                                          title: Text(cardapio.salada,style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color.fromARGB(157, 255, 255, 255))),
                                        ),
                                        ListTile(
                                          leading: const Text('Sobremesa: ',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 255, 255, 255)),),
                                          title: Text(cardapio.sobremesa,style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color.fromARGB(157, 255, 255, 255))),
                                        ),
                                        ListTile(
                                          leading: const Text('Suco: ',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 255, 255, 255)),),
                                          title: Text(cardapio.suco,style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color.fromARGB(157, 255, 255, 255))),
                                        )
                                      ],
                                    );
                                    } else {
                                        return Text('Erro ao carregar os itens');
                                      }             
                                    }
                                  } else if (snapshot.hasError) {
                                      return Text('Erro ao carregar os itens');
                                    } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                              }
                              )
                          ],
                        ),
                        const ExpansionTile(
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
                          subtitle: Text('Vegetariano'),
                        ),
                        const ExpansionTile(
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
                        const ExpansionTile(
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
                          subtitle: Text('Vegetariano'),
                        )
                      ],
                      ),
                     
                    ),
                  ),
                )
              ],
            )));
  }
}
