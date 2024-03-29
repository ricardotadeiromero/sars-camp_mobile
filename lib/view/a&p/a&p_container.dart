import 'package:sarscamp/controller/achados_perdidos_controller.dart';
import 'package:sarscamp/view/a&p/pages/a&p_error.dart';
import 'package:sarscamp/view/a&p/pages/a&p_loading.dart';
import 'package:sarscamp/view/a&p/pages/a&p_page.dart';
import 'package:sarscamp/repositories/achados_perdidos_repository.dart';
import 'package:flutter/material.dart';

class AchadosPerdidosContainer extends StatelessWidget {
  final AchadosPerdidosController controller =
      AchadosPerdidosController(AchadosPerdidosRepository());
  AchadosPerdidosContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AchadosPerdidosLoading();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return AchadosPerdidosPage(snapshot.data!);
        }
        if (snapshot.hasError) {
          final errorText = snapshot.error as dynamic;
          return AchadosPerdidosError(errorText.message);
        }
        return Container();
      },
    );
  }
}
