import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class saldoPage extends StatelessWidget {
  final _raController = TextEditingController();

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
                  child: SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                        ),
                        TextField(
                          
                        )
                      ],
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