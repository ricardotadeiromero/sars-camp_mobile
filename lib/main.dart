import 'package:TCC/controller/aluno_controller.dart';
import 'package:TCC/view/a&p/a&p_container.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';
import 'package:flutter/material.dart';
import 'package:TCC/view/cardapio/cardapio_container.dart';
import 'package:TCC/view/saldo/saldo_container.dart';
import 'package:provider/provider.dart';
import 'view/home_page.dart';

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
        '/a&pPage': (context) => AchadosPerdidosContainer()
      },
    );
  }
}
