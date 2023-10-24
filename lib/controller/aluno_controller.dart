import 'package:TCC/model/aluno.dart';
import 'package:TCC/repositories/aluno_repository.dart';
import 'package:TCC/service/prefs_aluno.dart';

class AlunoController{
  final IAlunoRepository repository;
  final PrefsAluno prefsAluno;

  AlunoController(this.repository, this.prefsAluno);

  Future<double> saldo(Aluno? aluno) async {
    final token = await prefsAluno.get();
    if(token==''){
      final response = await repository.login(aluno!);
      await prefsAluno.save(response);
      return await repository.saldo(response);
    }
    return await repository.saldo(token);
  }
  
  Future<bool> hasToken() async {
    final token = await prefsAluno.get();
    if(token==''){
      return false;
    }
    return true;
  }
}