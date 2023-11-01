import 'package:sarscamp/controller/cardapio_controller.dart';
import 'package:sarscamp/view/cardapio/pages/cardapio_error.dart';
import 'package:sarscamp/view/cardapio/pages/cardapio_loading.dart';
import 'package:sarscamp/view/cardapio/pages/cardapio_page.dart';
import 'package:sarscamp/repositories/cardapio_repository.dart';
import 'package:sarscamp/service/prefs_cardapio.dart';
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
          final errorText = snapshot.error as dynamic;
          return CardapioError(errorText.message);
        }

        return Container();
      },
    );
  }
}
