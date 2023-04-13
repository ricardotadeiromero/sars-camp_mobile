import 'dart:ui';
import 'package:tcc_telas/teste.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_telas/pages/cardapio_page.dart';
import 'package:tcc_telas/pages/saldo_page.dart';
import 'Componentes/CustomCard.dart';
import 'Componentes/Background.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          onStarPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Título do Alerta'),
                  content: Text('Conteúdo do Alerta'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        // Lógica para quando o botão "OK" é pressionado
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          onInfoPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Título do Alerta'),
                  content: Text('Conteúdo do Alerta'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        // Lógica para quando o botão "OK" é pressionado
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        body: Background(
          components: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                size: 140,
                imageAsset: 'image/cardapio.png',
                title: 'Cardápio RU',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => cardapioPage()),
                  );
                },
              ),
              CustomCard(
                size: 120,
                imageAsset: 'image/carteira.png',
                title: 'Saldo do RU',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => saldoPage()),
                  );
                },
              ),
              CustomCard(
                size: 130,
                imageAsset: 'image/achados-e-perdidos.png',
                title: 'Saldo do RU',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => saldoPage()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
