import 'package:sarscamp/configs/style.dart';
import 'package:flutter/material.dart';

class SaldoError extends StatelessWidget {
  final String error;
  const SaldoError(this.error, {super.key});

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
            Text(error, style: style)
          ],
        ),
      ),
    );
  }
}
