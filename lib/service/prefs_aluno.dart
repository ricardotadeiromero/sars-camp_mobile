import 'package:shared_preferences/shared_preferences.dart';

class PrefsAluno {
  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String> get() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return '';
    return token.toString();
  }
}
