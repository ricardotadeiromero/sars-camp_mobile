import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_telas/connection/connection.dart';
import 'componentes/Background.dart';
import 'Componentes/Saldo_page.dart';
import 'home_page.dart';

class saldoPage extends StatefulWidget {
  const saldoPage({super.key});

  @override
  State<saldoPage> createState() => _saldoPageState();
}

class _saldoPageState extends State<saldoPage> {
  final _raController = TextEditingController();
  final _senhaController = TextEditingController();
  late Future<double> _future;
  bool _raObrigatorio = false;
  Color _colorButton = Color.fromARGB(255, 17, 122, 130);
  Color _inputColor = Color(0xFF0A6066);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(shouldPopOnLogoPressed: true),
        body: Background(
            components: (Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleSaldoPage(),
            Center(
              child: MainContainerSaldo(
                  input: Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(children: [
                  TextField(
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
                        hintText: 'RA',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    cursorColor: _inputColor,
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 3,
                              color: _inputColor,
                            )),
                        filled: true,
                        fillColor: Colors.grey,
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _future = Connection.getSaldo(
                              _raController.text, _senhaController.text);
                        });
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFFA12E2F),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
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
                                        margin:
                                            EdgeInsets.only(top: 22, left: 5),
                                        child: FutureBuilder(
                                            future: _future,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  heightFactor: 2,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (snapshot.hasData) {
                                                final result = snapshot.data!;
                                                if (result == null) {
                                                  return Text('Deu ruim!');
                                                } else
                                                  return Text('Deu bom!');
                                              } else if (snapshot.hasError) {
                                                return Text('Deu ruim!');
                                              } else {
                                                return const Center(
                                                  heightFactor: 2,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            }))
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
                            });
                      },
                      child: Text('Consultar'),
                      style: ElevatedButton.styleFrom(
                        primary: _colorButton,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )
                ]),
              )),
            ),
          ],
        ))));
  }
}
