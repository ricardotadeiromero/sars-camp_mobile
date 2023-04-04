import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'connection/connection.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

void main() async{
  print(await http.get(Uri.parse("http://localhost:5000/")));

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
