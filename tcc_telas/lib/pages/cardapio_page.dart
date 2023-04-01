import 'dart:ui';
import '../controller/date_controller.dart';
import '../controller/cardapio_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class cardapioPage extends StatefulWidget {
  _CardapioPage createState() => _CardapioPage();
}

class _CardapioPage extends State<cardapioPage> {
  late DateTime selectedDay;
  var controller = CardapioController();

  @override
void initState() {
  super.initState();

}



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 5, child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA12E2F),
          leading: IconButton(
            icon: Image.asset('image/logo.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: 80,
          title: Text(
            'SARsCamp',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
          titleSpacing: 0,
          actions: [
            SizedBox(
              width: 50, // largura do espaço em pixels
              child: IconButton(
                icon: Icon(
                  Icons.star,
                  size: 40,
                ),
                onPressed: () {
                  // função chamada quando o ícone de estrela é pressionado
                },
              ),
            ),
            SizedBox(
              width: 50, // largura do espaço em pixels
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  size: 40,
                ),
                onPressed: () {
                  // função chamada quando o ícone de informações é pressionado
                },
              ),
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(text: 'Segunda'),
            Tab(text: 'Terça'),
            Tab(text: 'Quarta'),
            Tab(text: 'Quinta'),
            Tab(text: 'Sexta'),
            ],
            onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  selectedDay = DiaDaSemana.obterData(DateTime.monday);
                  break;
                case 1:
                  selectedDay = DiaDaSemana.obterData(DateTime.tuesday);
                  break;
                case 2:
                  selectedDay = DiaDaSemana.obterData(DateTime.wednesday);
                  break;
                case 3:
                  selectedDay = DiaDaSemana.obterData(DateTime.thursday);
                  break;
                case 4:
                  selectedDay = DiaDaSemana.obterData(DateTime.friday);
                  break;
              }
            });
            }
          ),
        ),
        body: Container(
            color: Color(0xFF0A6066),
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                ListView.separated(
                shrinkWrap: true,
                itemCount: controller.Cardap.length,
                itemBuilder: (BuildContext context, int i) {
                  final cardapio = controller.Cardap;
                  late String title;
                  late String trailing;
                  if(cardapio[i].aj == 1) {
                    title = "Almoço";
                    if(cardapio[i].vn == 1){
                      trailing = "Normal";
                    } else if(cardapio[i].vn == 0){
                      trailing = "Vegano";
                    }
                  } else if (cardapio[i].aj == 2){
                    title = "Jantar";
                    if(cardapio[i].vn == 1){
                      trailing = "Normal";
                    } else if(cardapio[i].vn == 0){
                      trailing = "Vegano";
                    }
                  } else if(cardapio[i].aj == 0) {
                    title = "Café da manhã";
                    trailing = "";
                  }
                  return ListTile(
                    title: Text(title, style: TextStyle(),),
                    trailing: Text(trailing),
                  );
                },
                separatorBuilder: (_,__) => Divider(),//Especificar o divisor
                ),
                ],
              ),
               ),
            )
          )
      );
  }
}
