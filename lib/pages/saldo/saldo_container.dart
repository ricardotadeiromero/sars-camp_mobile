import 'package:TCC/controller/aluno_controller.dart';
import 'package:TCC/pages/componentes/background.dart';
import 'package:TCC/pages/componentes/saldoPage.dart';
import 'package:TCC/pages/saldo/pages/saldo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoContainer extends StatelessWidget {
  const SaldoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AlunoController>(context);
    return Scaffold(
        appBar: const MyAppBar(shouldPopOnLogoPressed: true),
        body: Background(
            components: (SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleSaldoPage(),
                    ContainerSaldo(
                      input: FutureBuilder(
                        future: controller.hasToken(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MyProgressIndicator();
                          }
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.data!) {
                              return WithToken(controller);
                            }
                            return WithoutToken(controller);
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const MyProgressIndicator();
                        },
                      ),
                    )
                  ],
                )))));
  }
}
