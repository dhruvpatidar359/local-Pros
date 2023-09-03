import 'package:mysql1/mysql1.dart';

class DatabaseService {
  final MySqlConnection _connection;

  DatabaseService(this._connection);

  Future<void> registerUser(
      String email, String password, String userType, String name) async {
    final result = await _connection.query(
      'INSERT INTO user (email, password_hash, userType, name) VALUES (?, ?, ?, ?)',
      [email, password, userType, name],
    );
    if (result.affectedRows == 1) {
      // Registration successful
      print("success reg");
    } else {
      // Registration failed
      print("reg has been failed");
      print(result.affectedRows);
    }
  }

  Future<bool> loginUser(String email, String password, String userType) async {
    final result = await _connection.query(
      'SELECT email FROM user WHERE email = ? AND password_hash = ? AND userType = ?',
      [email, password, userType],
    );
    return result.isNotEmpty;
  }
}
