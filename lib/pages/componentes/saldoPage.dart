import 'package:TCC/pages/componentes/background.dart';
import 'package:flutter/material.dart';

class MainContainerSaldo extends StatelessWidget {
  final FutureBuilder<dynamic> input;
  MainContainerSaldo({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 100),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: myWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: myBlack.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: input,
            
          ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String text;
  const MyTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: myGreen,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 3,
                color: myGreen,
              )),
          filled: true,
          fillColor: myFillGrey,
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}

class TitleSaldoPage extends StatelessWidget {
  const TitleSaldoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 10, left: 10),
          width: 70,
          child: Image.asset('image/carteira.png'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: const Text(
            'Consulta do saldo RU',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
      ],
    ));
  }
}
