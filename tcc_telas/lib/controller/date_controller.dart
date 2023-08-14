class DiaDaSemana {
  static DateTime obterData(int diaSemana) {
    DateTime now = DateTime.now();
    int diff = diaSemana - now.weekday;
    DateTime data = now.add(Duration(days: diff));
    return DateTime(data.year, data.month, data.day);
  }

  static int numberWeek() {
    DateTime now = DateTime.now();
    int weekday = now.weekday - 1;

    if (weekday >= 0 && weekday <= 4) {
      // dia útil, retorna o número do dia (segunda = 1, terça = 2, etc)
      return weekday;
    } else {
      // final de semana, retorna o número da sexta-feira (6)
      return DateTime.friday - 1;
    }
  }
}
