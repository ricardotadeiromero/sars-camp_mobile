import 'package:TCC/model/aluno.dart';
import 'package:TCC/model/saldo.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';
import 'package:flutter/material.dart';

class AlunoController with ChangeNotifier {
  final IAlunoRepository repository;
  final PrefsAluno prefsAluno;

  AlunoController(this.repository, this.prefsAluno);

  Future<Saldo> saldo() async {
    final token = await prefsAluno.get();
    final saldo = await repository.saldo(token);
    return saldo;
  }

  Future<Saldo> loginSaldo(Aluno aluno) async {
    try {
      final response = await repository.login(aluno);
      await prefsAluno.save(response);
      notifyListeners();
      final saldo = await repository.saldo(response);
      return saldo;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> hasToken() async {
    final token = await prefsAluno.get();
    if (token == '') {
      return false;
    }
    return true;
  }

  void destroy() async {
    await prefsAluno.destroy();
    notifyListeners();
  }
}
