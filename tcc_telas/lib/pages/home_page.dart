import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA12E2F),
        leading: IconButton(
          icon: Image.asset('image/logo.png'),
          onPressed: (() => homePage()),
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
        child: Center(child: Image.asset('image/Unicamp.jpg')),
      ),
    );
  }
}
