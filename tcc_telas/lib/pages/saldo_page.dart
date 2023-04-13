import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class saldoPage extends StatelessWidget {
  final _raController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _raObrigatorio = false;
  Color _colorButton = Color.fromARGB(255, 17, 122, 130);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA12E2F),
        leading: IconButton(
          icon: Image.asset('image/logo.png'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        leadingWidth: 80,
        title: Text(
          'SARsCamp',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
        ),
        titleSpacing: 0,
        actions: [
          SizedBox(
            width: 50, // largura do espaço em pixels
            child: IconButton(
              icon: Icon(
                Icons.star,
                size: 40,
              ),
              onPressed: () {
                // função chamada quando o ícone de estrela é pressionado
              },
            ),
          ),
          SizedBox(
            width: 50, // largura do espaço em pixels
            child: IconButton(
              icon: Icon(
                Icons.info,
                size: 40,
              ),
              onPressed: () {
                // função chamada quando o ícone de informações é pressionado
              },
            ),
          ),
        ],
      ),
      body: Container(
          color: Color(0xFF0A6066),
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: Opacity(
                        opacity: 0.12,
                        child: Image.asset("image/Unicamp.png"),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
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
                  ),
                  Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFFA12E2F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: 'RA',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: 'Senha',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
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
              ),
              
            ],
          )
        )
    );
  }
}
