import 'package:TCC/controller/aluno_controller.dart';
import 'package:TCC/view/saldo/pages/saldo_error.dart';
import 'package:TCC/view/saldo/pages/saldo_loading.dart';
import 'package:TCC/view/saldo/pages/saldo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoContainer extends StatelessWidget {
  const SaldoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AlunoController>(context);
    return FutureBuilder(future: controller.hasToken(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return const SaldoLoading();
      }
      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        final token = snapshot.data!;
        if(token==true){
          return WithToken(controller);
        }
        return WithoutToken(controller);
      }
      if(snapshot.hasError){
        final errorText = snapshot.error as dynamic;
        return SaldoError(errorText.message);
      }
      return Container();
    },);
  }
}
