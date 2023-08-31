import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static final _host = 'localhost';
  static final _port = 3306;
  static final _user = 'root';
  static final _password = 'dhruv';
  static final _db = 'your_database';

  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _password,
      db: _db,
    );

    return await MySqlConnection.connect(settings);
  }
}
