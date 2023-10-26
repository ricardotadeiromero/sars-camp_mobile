import 'package:TCC/controller/aluno_controller.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';
import 'package:flutter/material.dart';
import 'package:TCC/pages/a&p_page.dart';
import 'package:TCC/pages/cardapio/cardapio_container.dart';
import 'package:TCC/pages/saldo/saldo_container.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AlunoController(AlunoRepository(), PrefsAluno()),
    child: const MyApp(),
  ));
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
        '/saldoPage': (context) => const SaldoContainer(),
        '/cardapioPage': (context) => CardapioContainer(),
        '/a&pPage': (context) => const AchaPerdi()
      },
    );
  }
}
