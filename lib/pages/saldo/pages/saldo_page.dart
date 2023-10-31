import 'dart:io';
import 'package:TCC/configs/style.dart';
import 'package:TCC/controller/aluno_controller.dart';
import 'package:TCC/model/aluno.dart';
import 'package:TCC/model/error.dart';
import 'package:TCC/pages/componentes/background.dart';
import 'package:TCC/pages/componentes/saldoPage.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';
import 'package:flutter/material.dart';
import 'package:TCC/connection/connection.dart';

class SaldoPage extends StatefulWidget {
  AlunoController controller;
  SaldoPage(this.controller, {super.key});

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
                  children: [
                    TitleSaldoPage(),
                    FutureBuilder(
                      future: widget.controller.hasToken(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data!) {
                            return WithToken(widget.controller);
                          }
                          return WithoutToken(widget.controller);
                        }
                        if (snapshot.hasError) {
                          return Container();
                        }
                        return Container();
                      },
                    )
                  ],
                )))));
  }
}

class WithoutToken extends StatefulWidget {
  AlunoController controller;
  WithoutToken(this.controller, {super.key});

  @override
  State<WithoutToken> createState() => _WithoutTokenState();
}

class _WithoutTokenState extends State<WithoutToken> {
  final style = const TextStyle(color: Colors.white, fontSize: 18);
  final styleSaldo = const TextStyle(color: Colors.white, fontSize: 20);
  final _formKey = GlobalKey<FormState>();
  final _raController = TextEditingController();
  final _senhaController = TextEditingController();
  late Future<String> _future;

  @override
  Widget build(BuildContext context) {
    return (Padding(
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
                errorStyle:
                    TextStyle(color: myInputGreen, fontWeight: FontWeight.w600),
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
                errorStyle:
                    TextStyle(color: myInputGreen, fontWeight: FontWeight.w600),
                hintText: 'Senha',
              ),
            ),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Aluno aluno =
                        Aluno(_raController.text, _senhaController.text);
                    widget.controller.loginSaldo(aluno).catchError((error) {
                      final errorText = error.message;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return SaldoDialog(errorText);
                        },
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

class WithToken extends StatelessWidget {
  AlunoController controller;
  WithToken(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return (FutureBuilder(
        future: controller.saldo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator();
          }
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            final saldo = snapshot.data!;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SaldoDialogDestroy(
                                  act: () {
                                    controller.destroy();
                                  },
                                );
                              });
                        },
                        icon: Icon(
                          Icons.arrow_circle_left,
                          color: myRed,
                        ),
                      )),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        saldo.name,
                        style: nomeStyle,
                      ),
                      Text(
                        "R\$: " + saldo.saldo.toString(),
                        style: saldoStyle,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            final errorText = snapshot.error as FonError;
            return Text(
              errorText.message,
              style: saldoStyle,
            );
          }
          return Container();
        }));
  }
}
