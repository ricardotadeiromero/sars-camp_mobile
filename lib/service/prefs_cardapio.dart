import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsCardapio {
  save(List<dynamic> listCardapios) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cardapios', json.encode(listCardapios));
  }

  dynamic get() async {
    final prefs = await SharedPreferences.getInstance();
    final listCardapios = prefs.getString('cardapios');
    if (listCardapios != null) {
      return json.decode(listCardapios);
    }
    return null;
  }
}
