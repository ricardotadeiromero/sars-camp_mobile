import 'dart:convert';

import 'package:flutter/material.dart';
import 'pages/home_page.dart';
//import 'connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'model/Cardapio.dart';
import 'package:http/http.dart' as http;
import 'connection/connection.dart';

void main() async{
  print(await Connection.getSaldo("201605", "clfon"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
