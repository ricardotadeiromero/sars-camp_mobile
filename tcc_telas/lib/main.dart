import 'package:flutter/material.dart';
import 'pages/home_page.dart';
//import 'connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'model/Cardapio.dart';
import 'package:http/http.dart' as http;

void main() {
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
