import 'package:TCC/configs/style.dart';
import 'package:TCC/pages/componentes/background.dart';
import 'package:flutter/material.dart';

class CardapioLoading extends StatelessWidget {
  const CardapioLoading({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Style.myRed,
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
            const MyProgressIndicator()
          ],
        ),
      ),
    );
  }
}