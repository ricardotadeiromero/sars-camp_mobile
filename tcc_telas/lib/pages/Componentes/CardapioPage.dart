import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../connection/connection.dart';
import '../../controller/date_controller.dart';
import '../../model/cardapio.dart';
import 'background.dart';

const TextStyle style =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white);
const TextStyle style2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color.fromARGB(157, 255, 255, 255));
const TextStyle style3 = TextStyle(color: Color.fromARGB(157, 255, 255, 255));
Color textColor = const Color.fromARGB(159, 255, 255, 255);

class ExpansionWidget extends StatelessWidget {
  Color iconColor = Color.fromARGB(159, 255, 255, 255);
  Color backgroundColor = Color.fromARGB(255, 193, 54, 57);
  Icon leadingIcon;
  String titleText;
  String subtitleText;
  Widget future;

  ExpansionWidget({
    required this.leadingIcon,
    required this.titleText,
    required this.subtitleText,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: iconColor,
      textColor: textColor,
      backgroundColor: backgroundColor,
      leading: leadingIcon,
      title: Text(
        titleText,
        style: style,
      ),
      subtitle: Text(subtitleText),
      children: [future],
    );
  }
}

class MyExpansionPanel extends StatefulWidget {
  Color? iconColor = Color.fromARGB(159, 255, 255, 255);
  Color backgroundColor = Color.fromARGB(255, 193, 54, 57);
  final Future<List<Cardapio>> future;

  MyExpansionPanel({
    super.key,
    required this.future,
  });

  @override
  State<MyExpansionPanel> createState() => _MyExpansionPanelState();
}

class _MyExpansionPanelState extends State<MyExpansionPanel> {
  final List<bool> _isExpanded = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return 
    ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        children: [
          ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                if (isExpanded) {
                  return ListTile(
                      iconColor: _isExpanded[0] ? widget.iconColor : null,
                      title: Text(
                        'Café da manhã',
                        style: style,
                      ),
                      leading: const Icon(Icons.sunny_snowing));
                } else
                  return ListTile(
                      iconColor: _isExpanded[0] ? widget.iconColor : null,
                      title: Text(
                        'Café da manhã',
                        style: style,
                      ),
                      leading: const Icon(Icons.sunny_snowing));
              },
              backgroundColor:
                  _isExpanded[0] ? widget.backgroundColor : Colors.transparent,
              canTapOnHeader: true,
              body: MyListViewCafe(),
              isExpanded: _isExpanded[0]),
          ExpansionPanel(
              backgroundColor:
                  _isExpanded[1] ? widget.backgroundColor : Colors.transparent,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                    iconColor: _isExpanded[1] ? widget.iconColor : null,
                    title: Text(
                      'Almoço',
                      style: style,
                    ),
                    subtitle: Text(
                      'Comum',
                      style: _isExpanded[1] ? style3 : null,
                    ),
                    leading: const Icon(Icons.sunny));
              },
              canTapOnHeader: true,
              body: CustomFutureBuilder<List<Cardapio>>(
                future: widget.future,
                periodo: 0,
                vegetariano: 0,
              ),
              isExpanded: _isExpanded[1]),
          ExpansionPanel(
              backgroundColor:
                  _isExpanded[2] ? widget.backgroundColor : Colors.transparent,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                    iconColor: _isExpanded[2] ? widget.iconColor : null,
                    title: Text(
                      'Almoço',
                      style: style,
                    ),
                    subtitle: Text(
                      'Vegano',
                      style: _isExpanded[2] ? style3 : null,
                    ),
                    leading: const Icon(Icons.sunny));
              },
              canTapOnHeader: true,
              body: CustomFutureBuilder<List<Cardapio>>(
                future: widget.future,
                periodo: 0,
                vegetariano: 1,
              ),
              isExpanded: _isExpanded[2]),
          ExpansionPanel(
              backgroundColor:
                  _isExpanded[3] ? widget.backgroundColor : Colors.transparent,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                    iconColor: _isExpanded[3] ? widget.iconColor : null,
                    title: Text(
                      'Jantar',
                      style: style,
                    ),
                    subtitle: Text(
                      'Comum',
                      style: _isExpanded[3] ? style3 : null,
                    ),
                    leading: const Icon(Icons.nightlight));
              },
              canTapOnHeader: true,
              body: CustomFutureBuilder<List<Cardapio>>(
                future: widget.future,
                periodo: 1,
                vegetariano: 0,
              ),
              isExpanded: _isExpanded[3]),
          ExpansionPanel(
              backgroundColor:
                  _isExpanded[4] ? widget.backgroundColor : Colors.transparent,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                    iconColor: _isExpanded[4] ? widget.iconColor : null,
                    title: Text(
                      'Jantar',
                      style: style,
                    ),
                    subtitle: Text(
                      'Vegano',
                      style: _isExpanded[4] ? style3 : null,
                    ),
                    leading: const Icon(Icons.nightlight));
              },
              canTapOnHeader: true,
              body: CustomFutureBuilder<List<Cardapio>>(
                future: widget.future,
                periodo: 1,
                vegetariano: 1,
              ),
              isExpanded: _isExpanded[4]),
        ],
        expansionCallback: (i, isExpanded) => setState(() {
              for (var j = 0; j <= 4; j++) {
                if (i == j) {
                  _isExpanded[j] = !isExpanded;
                } else
                  _isExpanded[j] = false;
              }
            }));
  }
}

class MyTab extends StatelessWidget {
  MyTab({super.key, required this.date});
  DateTime date;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: FutureBuilder<bool>(
        future: Connection.getFeriado(date),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data! ? 'Feriado' : DateFormat("dd/MM").format(date),
              style: snapshot.data! ? TextStyle(fontSize: 12) : null,
            );
          } else if (snapshot.hasError) {
            return const Text('Erro ao carregar');
          } else {
            return const MyProgressIndicator();
          }
        },
      ),
    );
  }
}

class ExpansionWidgetCafe extends StatelessWidget {
  Color iconColor = Color.fromARGB(159, 255, 255, 255);
  Color backgroundColor = Color.fromARGB(255, 193, 54, 57);
  Icon leadingIcon;
  String titleText;
  Widget future;

  ExpansionWidgetCafe({
    required this.leadingIcon,
    required this.titleText,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: iconColor,
      textColor: textColor,
      backgroundColor: backgroundColor,
      leading: leadingIcon,
      title: Text(
        titleText,
        style: style,
      ),
      children: [future],
    );
  }
}

class CustomFutureBuilder<T> extends StatelessWidget {
  final int periodo;
  final int vegetariano;
  final Future<List<Cardapio>> future;

  CustomFutureBuilder(
      {required this.future, required this.periodo, required this.vegetariano});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cardapio>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              heightFactor: 2,
              child: MyProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final list = snapshot.data!;
            if (list.isEmpty) {
              return Text('Erro ao carregar cardápio!', style: style);
            } else {
              var cardapio = null;
              for (var item in list) {
                if (item.periodo == periodo &&
                    item.vegetariano == vegetariano) {
                  cardapio = item;
                }
              }
              if (cardapio != null) {
                return MyListView(cardapio: cardapio);
              } else {
                return Text(
                  'Cardápio indisponível!',
                  style: style,
                );
              }
            }
          } else if (snapshot.hasError) {
            if (snapshot.error is HttpException) {
              return Text(
                (snapshot.error as HttpException).message,
                style: style,
              );
            } else {
              return Text(
                'Erro ao carregar cardápio!',
                style: style,
              );
            }
          } else {
            return const Center(
              heightFactor: 2,
              child: MyProgressIndicator(),
            );
          }
        });
  }
}

class MyListView extends StatelessWidget {
  final cardapio;
  MyListView({required this.cardapio});

  @override
  Widget build(BuildContext context) {
    if (cardapio.periodo == 1) {
      return ListView(shrinkWrap: true, children: [
        const ListTile(
          leading: Text(
            '18:00 - 19:30',
            style: style2,
          ),
        ),
        ListTile(
          leading: Text('Principal: ', style: style),
          title: Text(cardapio.principal, style: style2),
        ),
        ListTile(
          leading: Text('Guarnição: ', style: style),
          title: Text(cardapio.guarnicao, style: style2),
        ),
        ListTile(
          leading: Text('Salada: ', style: style),
          title: Text(cardapio.salada, style: style2),
        ),
        ListTile(
          leading: Text('Sobremesa: ', style: style),
          title: Text(cardapio.sobremesa, style: style2),
        ),
        ListTile(
          leading: Text('Suco: ', style: style),
          title: Text(cardapio.suco, style: style2),
        )
      ]);
    } else {
      return ListView(shrinkWrap: true, children: [
        const ListTile(
          leading: Text('11:00 - 14:00', style: style2),
        ),
        ListTile(
          leading: Text('Principal: ', style: style),
          title: Text(cardapio.principal, style: style2),
        ),
        ListTile(
          leading: Text('Guarnição: ', style: style),
          title: Text(cardapio.guarnicao, style: style2),
        ),
        ListTile(
          leading: Text('Salada: ', style: style),
          title: Text(cardapio.salada, style: style2),
        ),
        ListTile(
          leading: Text('Sobremesa: ', style: style),
          title: Text(cardapio.sobremesa, style: style2),
        ),
        ListTile(
          leading: Text('Suco: ', style: style),
          title: Text(cardapio.suco, style: style2),
        )
      ]);
    }
  }
}

class MyListViewCafe extends StatelessWidget {
  MyListViewCafe();

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      ListTile(
        leading: Text('07:00 - 08:30', style: style2),
      ),
      ListTile(
        leading: Text('Leite', style: style),
      ),
      ListTile(
        leading: Text('Café', style: style),
      ),
      ListTile(
        leading: Text('Achocolatado', style: style),
      ),
      ListTile(
        leading: Text('Pão Francês', style: style),
      ),
      ListTile(
        leading: Text('Margarina', style: style),
      ),
      ListTile(
        leading: Text('Geléia', style: style),
      ),
      ListTile(
        leading: Text('Fruta', style: style),
      ),
    ]);
  }
}
