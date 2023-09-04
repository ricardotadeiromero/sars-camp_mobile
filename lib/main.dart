import 'package:flutter/material.dart';
import 'package:TCC/pages/a&p_page.dart';
import 'package:TCC/pages/cardapio_page.dart';
import 'package:TCC/pages/saldo_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/saldoPage': (context) => const SaldoPage(),
        '/cardapioPage': (context) => const CardapioPage(),
        '/a&pPage': (context) => const AchaPerdi()
      },
    );
  }
}
