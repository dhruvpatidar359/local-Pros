import 'package:mysql1/mysql1.dart';

class DatabaseManager {
  final _host = 'bsi7hofv2ioroqtkezlf-mysql.services.clever-cloud.com';
  final _port = 3306;
  final _user = 'um2l11tsadmxrmua';
  final _password = '7slCqhgRdTnumE8ldaNn';
  final _db = 'bsi7hofv2ioroqtkezlf';

  late MySqlConnection _connection;
  static final DatabaseManager _instance = DatabaseManager._internal();

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<void> initialize() async {
    _connection = await MySqlConnection.connect(ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _password,
      db: _db,
    ));
  }

  MySqlConnection get connection => _connection;
}
