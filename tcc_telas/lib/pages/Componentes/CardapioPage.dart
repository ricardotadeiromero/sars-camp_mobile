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
  final List<dynamic> cardapios;

  MyExpansionPanel({super.key, required this.cardapios});

  @override
  State<MyExpansionPanel> createState() => _MyExpansionPanelState();
}

class _MyExpansionPanelState extends State<MyExpansionPanel> {
  final List<bool> _isExpanded = [false, false, true, false, false];
  @override
  Widget build(BuildContext context) {
    print("fonfi2");
    print(widget.cardapios);
    return ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        children: widget.cardapios
            .map((cardapio) => ExpansionPanel(
                backgroundColor: myGreen,
                isExpanded: true,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(cardapio.periodo == 1 ? "Janta" : "Almoço"),
                    subtitle: Text(
                        cardapio.vegetariano == 1 ? "Vegetariano" : "Comum"),
                  );
                },
                body: MyListView(cardapio: cardapio)))
            .toList(),
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
  final Future<Cardapio> future;

  CustomFutureBuilder({required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cardapio>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              heightFactor: 2,
              child: MyProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return MyListView(cardapio: snapshot.data!);
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
  final Cardapio cardapio;
  MyListView({required this.cardapio});

  @override
  Widget build(BuildContext context) {
    print("fonfi3");
    print(cardapio);
    if (cardapio.periodo == 1) {
      if (cardapio.vegetariano == 0) {
        return ListView(shrinkWrap: true, children: [
          const ListTile(
            leading: Text(
              '18:00 - 19:45',
              style: style2,
            ),
          ),
          ListTile(
            leading: Text(
              'Arroz e feijão',
              style: style,
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
            leading: Text(
              '18:00 - 19:45',
              style: style2,
            ),
          ),
          ListTile(
            leading: Text(
              'Arroz integral e feijão',
              style: style,
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
      }
    } else {
      if (cardapio.vegetariano == 0) {
        return ListView(shrinkWrap: true, children: [
          const ListTile(
            leading: Text(
              '11:00 - 14:00',
              style: style2,
            ),
          ),
          ListTile(
            leading: Text(
              'Arroz e feijão',
              style: style,
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
            leading: Text(
              '11:00 - 14:00',
              style: style2,
            ),
          ),
          ListTile(
            leading: Text(
              'Arroz integral e feijão',
              style: style,
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
      }
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
