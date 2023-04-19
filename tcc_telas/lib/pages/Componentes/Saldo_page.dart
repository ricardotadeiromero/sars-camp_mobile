import 'package:flutter/material.dart';

Color _inputColor = Color(0xFF0A6066);

class MainContainerSaldo extends StatelessWidget {
  Widget? input;
  MainContainerSaldo({super.key, this.input});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
      color: Color(0xFFA12E2F),
      borderRadius: BorderRadius.circular(20),
      ),
      child: input,
    );
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
          )
        ),
        filled: true,
        fillColor: Colors.grey,
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
        )
      ),
    );
  }
}

class TitleSaldoPage extends StatelessWidget {
  const TitleSaldoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                      ),
                  ],
                );
  }
}
