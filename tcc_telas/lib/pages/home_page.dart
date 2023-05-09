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
        appBar: MyAppBar(shouldPopOnLogoPressed: false),
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
                  Navigator.pushNamed(context, '/cardapioPage');
                },
              ),
              CustomCard(
                size: 120,
                imageAsset: 'image/carteira.png',
                title: 'Saldo do RU',
                onTap: () {
                  Navigator.pushNamed(context, '/saldoPage');
                },
              ),
              CustomCard(
                size: 130,
                imageAsset: 'image/achados-e-perdidos.png',
                title: 'Achados & Perdidos',
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ));
  }
}
