import 'package:TCC/configs/style.dart';
import 'package:TCC/view/components/background.dart';
import 'package:flutter/material.dart';

class SaldoLoading extends StatelessWidget {
  const SaldoLoading({super.key});

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
                child: Image.asset('image/carteira.png')),
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
