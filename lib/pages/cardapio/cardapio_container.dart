import 'package:TCC/controller/cardapio_controller.dart';
import 'package:TCC/pages/cardapio/pages/cardapio_error.dart';
import 'package:TCC/pages/cardapio/pages/cardapio_loading.dart';
import 'package:TCC/pages/cardapio/pages/cardapio_page.dart';
import 'package:TCC/repositories/cardapio_repository.dart';
import 'package:TCC/service/prefs_cardapio.dart';
import 'package:flutter/material.dart';

class CardapioContainer extends StatelessWidget {
  CardapioContainer({super.key});
  final CardapioController controller =
      CardapioController(CardapioRepository(), PrefsCardapio());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.findWeek(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CardapioLoading();
        }
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return CardapioPage(snapshot.data!);
        }
        if (snapshot.hasError) {
          return const CardapioError('Cardápio não encontrado!');
        }

        return Container();
      },
    );
  }
}
