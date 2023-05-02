import 'package:flutter/material.dart';

Color _inputColor = Color(0xFF0A6066);

class MainContainerSaldo extends StatelessWidget {
  Widget? input;
  MainContainerSaldo({super.key, this.input});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 100),
          padding: EdgeInsets.only(bottom: 30),
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: input,
        ));
  }
}

class MyTextField extends StatelessWidget {
  String text;
  MyTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: _inputColor,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 3,
                color: _inputColor,
              )),
          filled: true,
          fillColor: Colors.grey,
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
          margin: EdgeInsets.only(right: 15, top: 10, left: 10),
          width: 70,
          child: Image.asset('image/carteira.png'),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            'Consulta do saldo RU',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
      ],
    ));
  }
}
