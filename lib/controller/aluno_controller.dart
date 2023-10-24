import 'package:TCC/model/aluno.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';
import 'package:flutter/material.dart';

class AlunoController with ChangeNotifier{
  final IAlunoRepository repository;
  final PrefsAluno prefsAluno;

  AlunoController(this.repository, this.prefsAluno);

  Future<String> saldo() async {
    final token = await prefsAluno.get();
    return await repository.saldo(token);
  }
  Future<String> loginSaldo(Aluno aluno) async {
      final response = await repository.login(aluno);
      await prefsAluno.save(response);
      notifyListeners();
      return await repository.saldo(response);
  }
  
  Future<bool> hasToken() async {
    final token = await prefsAluno.get();
    if(token==''){
      return false;
    }
    return true;
  }

  void destroy() async {
    await prefsAluno.destroy();
    notifyListeners();
  }
}