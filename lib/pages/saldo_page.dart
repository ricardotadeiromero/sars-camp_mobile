import 'dart:io';
import 'package:flutter/material.dart';
import 'package:TCC/connection/connection.dart';
import 'componentes/background.dart';
import 'componentes/saldoPage.dart';

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
            components: (SizedBox(
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
  final styleSaldo = const TextStyle(color: Colors.white, fontSize: 20);
  final _formKey = GlobalKey<FormState>();
  final _raController = TextEditingController();
  final _senhaController = TextEditingController();
  late Future<String> _future;

  @override
  Widget build(BuildContext context) {
    return MainContainerSaldo(
        input: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
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
                  cursorColor: myFormRed,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: myFormRed,
                    )),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: myInputGreen)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: myFormRed)),
                    errorStyle: TextStyle(
                        color: myInputGreen, fontWeight: FontWeight.w600),
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
                  cursorColor: myFormRed,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: myFormRed,
                    )),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: myInputGreen)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: myFormRed)),
                    errorStyle: TextStyle(
                        color: myInputGreen, fontWeight: FontWeight.w600),
                    hintText: 'Senha',
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _future = Connection.getSaldo(
                              _raController.text, _senhaController.text);
                        });
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: myFormRed,
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
                                                    color: myButtonGreen,
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                final result = snapshot.data;
                                                if (result == null) {
                                                  return Text(
                                                    'O seu saldo é $result',
                                                    style: style,
                                                  );
                                                } else {
                                                  return Text(
                                                      'O seu saldo é: $result',
                                                      style: styleSaldo);
                                                }
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
                                                    color: myButtonGreen,
                                                  ),
                                                );
                                              }
                                            }))
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: myButtonGreen,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myFormRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Consultar'),
                  ),
                )
              ]),
            )));
  }
}
