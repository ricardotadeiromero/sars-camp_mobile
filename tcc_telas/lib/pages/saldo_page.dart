import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'componentes/Background.dart';
import 'Componentes/Saldo_page.dart';

import 'home_page.dart';

class saldoPage extends StatelessWidget {
  final _raController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _raObrigatorio = false;
  Color _colorButton = Color.fromARGB(255, 17, 122, 130);
  Color _inputColor = Color(0xFF0A6066);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(shouldPopOnLogoPressed: true),
      body: Background(
              components: (
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const TitleSaldoPage(),
                Center(
                child: MainContainerSaldo(  
                  input: Padding(
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Column(
                      children: [
                        MyTextField(text: 'RA'),
                        SizedBox(height: 20),
                        MyTextField(text: 'Senha'),
                        SizedBox(height: 25),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,

                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFFA12E2F),
                                    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                    title: Text(
                                      'Saldo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    content: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          margin: EdgeInsets.only(top: 15, left: 5),
                                          child: Image.asset("image/carteira.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 22, left: 5),
                                          child: Text(
                                            'O seu saldo é R\$111,00.',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        child: Text('OK'),
                                        style: ElevatedButton.styleFrom(
                                          primary: _colorButton,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                            child: Text('Consultar'),
                            style: ElevatedButton.styleFrom(
                              primary: _colorButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                      )
                      ]
                    ),
                  )
                ),
              ),
                ],
              )
          )
        )
    );
  }
}
