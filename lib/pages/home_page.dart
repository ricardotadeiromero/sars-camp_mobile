import 'package:flutter/material.dart';
import 'componentes/customCard.dart';
import 'componentes/background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(shouldPopOnLogoPressed: false),
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
                  Navigator.pushNamed(context, '/a&pPage');
                },
              ),
            ],
          ),
        ));
  }
}
