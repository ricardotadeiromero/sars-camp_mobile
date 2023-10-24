import 'package:TCC/model/cardapio.dart';

class DateController {
  static DateTime obterData(int diaSemana) {
    DateTime now = DateTime.now();
    int diff = diaSemana - now.weekday;
    DateTime data = now.add(Duration(days: diff));
    return DateTime(data.year, data.month, data.day);
  }

  static int numberWeek(List<List<Cardapio>> list) {
    //calculo do initial index;
    int mday = 0;
    for (var card in list) {
      print('fonfifon');
      print(DateTime.now().day);
      if (list.indexOf(card) > mday) {
        mday = list.indexOf(card);
        if (card[0].data.day > DateTime.now().day &&
            card[0].data.month == DateTime.now().month) {
          return list.indexOf(card);
        }
        if (card[0].data.day == DateTime.now().day &&
            card[0].data.month == DateTime.now().month) {
          return list.indexOf(card);
        }
      }
    }
    return mday;
  }
}
