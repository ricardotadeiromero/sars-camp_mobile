import 'package:flutter/material.dart';
import '../../model/Cardapio.dart';

TextStyle style =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white);
TextStyle style2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color.fromARGB(157, 255, 255, 255));
Color textColor = Color.fromARGB(159, 255, 255, 255);

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
              child: CircularProgressIndicator(),
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
            return Text(
              'Erro ao carregar cardápio!',
              style: style,
            );
          } else {
            return const Center(
              heightFactor: 2,
              child: CircularProgressIndicator(),
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
    return ListView(shrinkWrap: true, children: [
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
