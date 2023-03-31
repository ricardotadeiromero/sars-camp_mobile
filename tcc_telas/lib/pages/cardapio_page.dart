import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class cardapioPage extends StatefulWidget {
  
  _CardapioPage createState() => _CardapioPage();

}

class _CardapioPage extends State<cardapioPage>{

  List<DateTime> _daysOfWeek = [];

  @override
  void initState() {
    super.initState();

    // Obter a data atual e determinar o dia da semana em que a semana começa (segunda-feira).
    DateTime now = DateTime.now();
    int weekDay = now.weekday;
    int diff = (weekDay - DateTime.monday) % 7;

    // Criar uma lista de datas para os próximos sete dias da semana.
    DateTime startOfWeek = now.subtract(Duration(days: diff));
    for (int i = 0; i < 7; i++) {
      _daysOfWeek.add(startOfWeek.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA12E2F),
        leading: IconButton(
          icon: Image.asset('image/logo.png'),
          onPressed: (){
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
      ),
      body: Container(
          color: Color(0xFF0A6066),
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: Opacity(
                        opacity: 0.12,
                        child: Image.asset("image/Unicamp.png"),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFFA12E2F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: _daysOfWeek.length,
                    itemBuilder: (BuildContext context, int index){
                    String formattedDate = DateFormat('dd/MM').format(_daysOfWeek[index]);
                    return ListTile(
                    title: Text('$formattedDate'), );

                  }),
                ),
              ),
            ],
          )
        )
    );
  }

}