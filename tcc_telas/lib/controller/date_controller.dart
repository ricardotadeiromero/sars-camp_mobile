class DiaDaSemana {
  static DateTime obterData(int diaSemana) {
    DateTime now = DateTime.now();
    int diff = diaSemana - now.weekday;
    DateTime data = now.add(Duration(days: diff));
    return DateTime(data.year, data.month, data.day);
  }


}