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
          bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 15, 142, 147),
            tabs: [
            Tab(text: DateFormat("dd/MM"). format(DiaDaSemana.obterData(DateTime.monday))),
            Tab(text: DateFormat("dd/MM"). format(DiaDaSemana.obterData(DateTime.tuesday))),
            Tab(text: DateFormat("dd/MM"). format(DiaDaSemana.obterData(DateTime.wednesday))),
            Tab(text: DateFormat("dd/MM"). format(DiaDaSemana.obterData(DateTime.thursday))),
            Tab(text: DateFormat("dd/MM"). format(DiaDaSemana.obterData(DateTime.friday))),
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
            color: Color.fromARGB(192, 10, 96, 102),
            width: double.infinity,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                ListView.separated(
                shrinkWrap: true,
                itemCount: controller.Cardap.length,
                itemBuilder: (BuildContext context, int i) {
                  final cardapio = controller.Cardap;
                  late String title;
                  late String trailing;
                  
                  if(cardapio[i].aj == 0) {
                    title = "Café da manhã";
                    trailing = "";
                  } else if(cardapio[i].aj == 1) {
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
                  }  
                  return ListTile(
                    title: Text(title, 
                     style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),),
                    trailing: Text(trailing,
                     style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color.fromARGB(180, 255, 255, 255))
                    ),
                    tileColor: Color(0xFF0A6066),
                  );
                },
                separatorBuilder: (_,__) => Divider(),//Especificar o divisor
                padding: EdgeInsets.all(16),
                ),
                ],
              ),
               ),
            )
          )
      );
  }
}
