import 'package:mysql1/mysql1.dart';

class Connection{

  Future<MySqlConnection> getConnection() async{
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '143.106.241',
      port: 3306,
      user: 'cl201605',
      password: 'cl*20122005',
      db: 'cl201605',
    ));
    return conn;
  }
  
}