import 'package:sarscamp/configs/style.dart';
import 'package:flutter/material.dart';

class AchadosPerdidosError extends StatelessWidget {
  final String error;
  const AchadosPerdidosError(this.error, {super.key});

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
                    tag: 'image/achados-e-perdidos.png',
                    child: Image.asset('image/achados-e-perdidos.png'))),
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
