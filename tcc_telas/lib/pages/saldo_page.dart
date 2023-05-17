import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tcc_telas/connection/connection.dart';
import 'componentes/Background.dart';
import 'Componentes/Saldo_page.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({super.key});

  @override
  State<SaldoPage> createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(shouldPopOnLogoPressed: true),
        body: Background(
            components: (Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TitleSaldoPage(),
                    SaldoContainer(),
                  ],
                )))));
  }
}

class SaldoContainer extends StatefulWidget {
  const SaldoContainer({super.key});

  @override
  State<SaldoContainer> createState() => _SaldoContainerState();
}

class _SaldoContainerState extends State<SaldoContainer> {
  final style = const TextStyle(color: Colors.white, fontSize: 18);
  final styleSaldo = TextStyle(color: Colors.white, fontSize: 20);
  final _formKey = GlobalKey<FormState>();
  final _raController = TextEditingController();
  final _senhaController = TextEditingController();
  late Future<String> _future;
  bool _raObrigatorio = false;
  final Color _darkRed = Color.fromARGB(255, 131, 33, 35);
  final Color _myRed = Color(0xFFA12E2F);
  final Color _lightRed = Color(0xFFD42A2A);
  final Color _colorButton = Color(0xFF007F82);
  final Color _inputColor = Color(0xFF0A6066);
  @override
  Widget build(BuildContext context) {
    return MainContainerSaldo(
        input: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: _raController,
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return 'Preencha o campo!';
                    }
                    return null;
                  },
                  cursorColor: _myRed,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: _myRed,
                    )),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _inputColor)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _myRed)),
                    errorStyle: TextStyle(
                        color: _inputColor, fontWeight: FontWeight.w600),
                    hintText: 'RA',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return 'Preencha o campo!';
                    }
                    return null;
                  },
                  cursorColor: _myRed,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: _myRed,
                    )),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _inputColor)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _myRed)),
                    errorStyle: TextStyle(
                        color: _inputColor, fontWeight: FontWeight.w600),
                    hintText: 'Senha',
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _future = Connection.getSaldo2(
                              _raController.text, _senhaController.text);
                        });
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFFA12E2F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Row(
                                  children: [
                                    const Text(
                                      'Saldo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                      ),
                                    ),
                                    Container(
                                      width: 45,
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Image.asset("image/carteira.png"),
                                    ),
                                  ],
                                ),
                                content: Wrap(
                                  children: [
                                    Center(
                                        child: FutureBuilder(
                                            future: _future,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  heightFactor: 2,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: _colorButton,
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                final result = snapshot.data!;
                                                if (result == null) {
                                                  return Text(
                                                    result,
                                                    style: style,
                                                  );
                                                } else
                                                  return Text(result,
                                                      style: styleSaldo);
                                              } else if (snapshot.hasError) {
                                                if (snapshot.error
                                                    is HttpException) {
                                                  return Text(
                                                    (snapshot.error
                                                            as HttpException)
                                                        .message,
                                                    style: style,
                                                  );
                                                } else {
                                                  return Text(
                                                      'Erro ao carregar o saldo!'
                                                          .toString(),
                                                      style: style);
                                                }
                                              } else {
                                                return Center(
                                                  heightFactor: 2,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: _colorButton,
                                                  ),
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
                      }
                    },
                    child: Text('Consultar'),
                    style: ElevatedButton.styleFrom(
                      primary: _myRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ]),
            )));
  }
}
