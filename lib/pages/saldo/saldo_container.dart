import 'dart:js';

import 'package:TCC/controller/aluno_controller.dart';
import 'package:TCC/pages/saldo/pages/saldo_page.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoContainer extends StatelessWidget {
  
  SaldoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AlunoController>(context);
    return SaldoPage(controller);
  }
}