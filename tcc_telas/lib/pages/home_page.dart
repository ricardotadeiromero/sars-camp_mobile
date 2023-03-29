import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA12E2F),
        leading:IconButton(
            icon: Image.asset('image/logo.png'),
            onPressed: (() => homePage()),
          ),
          leadingWidth: 100,
          title: Text('SARsCamp'), 
      ),
      body: Container(
        color: Color(0xFF0A6066),
        child: Center(
          child: Image.asset('image/Unicamp')
        ),
      ),
    );
  }
}