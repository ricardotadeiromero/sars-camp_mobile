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
    try {
      final token = await prefsAluno.get();
      final saldo = await repository.saldo(token);
      return saldo;
    } catch (e) {
      if (e.toString().contains('401')) {
        await prefsAluno.destroy();
        notifyListeners();
      }
      rethrow;
    }
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
    await Future.delayed(const Duration(seconds: 1));
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
