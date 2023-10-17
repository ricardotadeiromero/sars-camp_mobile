import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/Cardapio.dart';
import 'background.dart';

const TextStyle style =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white);

const TextStyle style2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color.fromARGB(157, 255, 255, 255));

const TextStyle style3 = TextStyle(color: Color.fromARGB(157, 255, 255, 255));

class LoadingPage extends StatelessWidget {
  final bool type;
  const LoadingPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myRed,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 250,
                child: Hero(
                    tag: 'image/cardapio.png',
                    child: Image.asset('image/cardapio.png'))),
            const SizedBox(
              height: 10,
            ),
            type
                ? const MyProgressIndicator()
                : const Text(
                    'Cardápios indisponíveis!',
                    style: style,
                  )
          ],
        ),
      ),
    );
  }
}

/// Uma ExpasionPanelList com um ExpansionPanel para cada Cardapio de um dia.
class CardapiosDiaPanel extends StatefulWidget {
  final Color myBackgroundRed = const Color.fromARGB(255, 193, 54, 57);
  final Color? myIconGray = const Color.fromARGB(159, 255, 255, 255);
  final List<Cardapio> cardapios;

  const CardapiosDiaPanel({super.key, required this.cardapios});

  @override
  State<CardapiosDiaPanel> createState() => _CardapiosDiaPanelState();
}

class _CardapiosDiaPanelState extends State<CardapiosDiaPanel> {
  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    // Inicialize _isExpanded com o tamanho correto e defina todos os valores como false.
    _isExpanded = List.filled(widget.cardapios.length + 1, false);
  }

  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> cardapioPanels = [];

    cardapioPanels.add(ExpansionPanel(
        isExpanded: _isExpanded[0],
        canTapOnHeader: true,
        backgroundColor:
            _isExpanded[0] ? widget.myBackgroundRed : myTransparent,
        headerBuilder: (context, isExpanded) {
          return ListTile(
            iconColor: _isExpanded[0] ? widget.myIconGray : null,
            leading: const Icon(Icons.breakfast_dining),
            title: const Text("Café da Manhã"),
          );
        },
        body: const MyListViewCafe()));

    cardapioPanels.addAll(widget.cardapios.asMap().entries.map((entry) {
      int index = entry.key + 1;
      var cardapio = entry.value;
      return ExpansionPanel(
        isExpanded: _isExpanded[index],
        canTapOnHeader: true,
        backgroundColor:
            _isExpanded[index] ? widget.myBackgroundRed : myTransparent,
        headerBuilder: (context, isExpanded) {
          return ListTile(
            iconColor: _isExpanded[index] ? widget.myIconGray : null,
            leading:
                Icon(cardapio.periodo == 1 ? Icons.nightlight : Icons.sunny),
            title: Text(cardapio.periodo == 1 ? "Janta" : "Almoço"),
            subtitle: Text(cardapio.vegetariano == 1 ? "Vegetariano" : "Comum"),
          );
        },
        body: CardapioView(cardapio: cardapio),
      );
    }));

    return ExpansionPanelList(
      animationDuration: const Duration(seconds: 1),
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      children: cardapioPanels,
      expansionCallback: (i, isExpanded) {
        setState(() {
          for (var j = 0; j < _isExpanded.length; j++) {
            _isExpanded[j] = j == i ? isExpanded : false;
          }
        });
      },
    );
  }
}

/// A Tab da NavBar com os cardápios do dia
class CardapiosDiaTab extends StatelessWidget {
  const CardapiosDiaTab({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Text(
      DateFormat("dd/MM").format(date),
      style: const TextStyle(fontSize: 12),
    ));
  }
}

class ExpansionWidgetCafe extends StatelessWidget {
  final Color myIconExpansionGray = const Color.fromARGB(159, 255, 255, 255);
  final Color myBackgroundExpansionRed = const Color.fromARGB(255, 193, 54, 57);
  final Icon leadingIcon;
  final String titleText;
  final Widget future;

  const ExpansionWidgetCafe({
    super.key,
    required this.leadingIcon,
    required this.titleText,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: myIconExpansionGray,
      textColor: myLightGray,
      backgroundColor: myBackgroundExpansionRed,
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

  const CustomFutureBuilder({super.key, required this.future});

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
            return CardapioView(cardapio: snapshot.data!);
          } else {
            return const Center(
              heightFactor: 2,
              child: MyProgressIndicator(),
            );
          }
        });
  }
}

class CardapioView extends StatelessWidget {
  final Cardapio cardapio;
  const CardapioView({super.key, required this.cardapio});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("fonfi3");
      print(cardapio);
    }

    if (cardapio.periodo == 1) {
      if (cardapio.vegetariano == 0) {
        return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const ListTile(
                leading: Text(
                  '18:00 - 19:45',
                  style: style2,
                ),
              ),
              const ListTile(
                leading: Text(
                  'Arroz e feijão',
                  style: style,
                ),
              ),
              ListTile(
                leading: const Text('Principal: ', style: style),
                title: Text(cardapio.principal, style: style2),
              ),
              ListTile(
                leading: const Text('Guarnição: ', style: style),
                title: Text(cardapio.guarnicao, style: style2),
              ),
              ListTile(
                leading: const Text('Salada: ', style: style),
                title: Text(cardapio.salada, style: style2),
              ),
              ListTile(
                leading: const Text('Sobremesa: ', style: style),
                title: Text(cardapio.sobremesa, style: style2),
              ),
              ListTile(
                leading: const Text('Suco: ', style: style),
                title: Text(cardapio.suco, style: style2),
              )
            ]);
      } else {
        return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const ListTile(
                leading: Text(
                  '18:00 - 19:45',
                  style: style2,
                ),
              ),
              const ListTile(
                leading: Text(
                  'Arroz integral e feijão',
                  style: style,
                ),
              ),
              ListTile(
                leading: const Text('Principal: ', style: style),
                title: Text(cardapio.principal, style: style2),
              ),
              ListTile(
                leading: const Text('Guarnição: ', style: style),
                title: Text(cardapio.guarnicao, style: style2),
              ),
              ListTile(
                leading: const Text('Salada: ', style: style),
                title: Text(cardapio.salada, style: style2),
              ),
              ListTile(
                leading: const Text('Sobremesa: ', style: style),
                title: Text(cardapio.sobremesa, style: style2),
              ),
              ListTile(
                leading: const Text('Suco: ', style: style),
                title: Text(cardapio.suco, style: style2),
              )
            ]);
      }
    } else {
      if (cardapio.vegetariano == 0) {
        return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const ListTile(
                leading: Text(
                  '11:00 - 14:00',
                  style: style2,
                ),
              ),
              const ListTile(
                leading: Text(
                  'Arroz e feijão',
                  style: style,
                ),
              ),
              ListTile(
                leading: const Text('Principal: ', style: style),
                title: Text(cardapio.principal, style: style2),
              ),
              ListTile(
                leading: const Text('Guarnição: ', style: style),
                title: Text(cardapio.guarnicao, style: style2),
              ),
              ListTile(
                leading: const Text('Salada: ', style: style),
                title: Text(cardapio.salada, style: style2),
              ),
              ListTile(
                leading: const Text('Sobremesa: ', style: style),
                title: Text(cardapio.sobremesa, style: style2),
              ),
              ListTile(
                leading: const Text('Suco: ', style: style),
                title: Text(cardapio.suco, style: style2),
              )
            ]);
      } else {
        return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const ListTile(
                leading: Text(
                  '11:00 - 14:00',
                  style: style2,
                ),
              ),
              const ListTile(
                leading: Text(
                  'Arroz integral e feijão',
                  style: style,
                ),
              ),
              ListTile(
                leading: const Text('Principal: ', style: style),
                title: Text(cardapio.principal, style: style2),
              ),
              ListTile(
                leading: const Text('Guarnição: ', style: style),
                title: Text(cardapio.guarnicao, style: style2),
              ),
              ListTile(
                leading: const Text('Salada: ', style: style),
                title: Text(cardapio.salada, style: style2),
              ),
              ListTile(
                leading: const Text('Sobremesa: ', style: style),
                title: Text(cardapio.sobremesa, style: style2),
              ),
              ListTile(
                leading: const Text('Suco: ', style: style),
                title: Text(cardapio.suco, style: style2),
              )
            ]);
      }
    }
  }
}

class MyListViewCafe extends StatelessWidget {
  const MyListViewCafe({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: const [
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
