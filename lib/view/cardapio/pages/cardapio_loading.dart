import 'package:sarscamp/configs/style.dart';
import 'package:sarscamp/view/components/background.dart';
import 'package:flutter/material.dart';

class CardapioLoading extends StatelessWidget {
  const CardapioLoading({super.key});

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
            const MyProgressIndicator()
          ],
        ),
      ),
    );
  }
}
