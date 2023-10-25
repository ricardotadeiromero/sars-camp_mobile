import 'package:TCC/configs/style.dart';
import 'package:TCC/controller/date_controller.dart';
import 'package:TCC/model/cardapio.dart';
import 'package:TCC/pages/componentes/background.dart';
import 'package:TCC/pages/componentes/cardapioPage.dart';
import 'package:flutter/material.dart';

class CardapioPage extends StatefulWidget {
  final List<List<Cardapio>> listCardapio;
  const CardapioPage(this.listCardapio, {super.key});

  @override
  State<CardapioPage> createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(
        length: widget.listCardapio.length,
        vsync: this,
        initialIndex: DateController.numberWeek(widget.listCardapio));
    return Scaffold(
        appBar: MyAppBar(
          shouldPopOnLogoPressed: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: TabBar(
                controller: controller,
                isScrollable: false,
                indicatorColor: myAquaGreen,
                tabs: widget.listCardapio
                    .map((e) => CardapiosDiaTab(date: e[0].data))
                    .toList(),
              )),
        ),
        body: Background(
          components: Container(
              alignment: AlignmentDirectional.topStart,
              child: TabBarView(
                //physics: ClampingScrollPhysics(),
                controller: controller,
                children: widget.listCardapio
                    .map((cardapios) => CardapioBodyPage(cardapios: cardapios))
                    .toList(),
              )),
        ));
  }
}
