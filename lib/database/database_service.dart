import 'dart:developer';

import 'package:localpros/database/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  MySqlConnection _connection = DatabaseManager().connection;

  DatabaseManager databaseManager = DatabaseManager();

  Future<void> registerUser(
      String email, String password, String userType, String name) async {
    if (userType == 'consumer') {
      late Results result;

      try {
        result = await _connection.query(
          'INSERT INTO consumer (email, password, name) VALUES (?, ?, ?)',
          [email, password, name],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'INSERT INTO consumer (email, password, name) VALUES (?, ?, ?)',
          [email, password, name],
        );
      }

      if (result.affectedRows == 1) {
        // Registration successful
        print("success reg");
      } else {
        // Registration failed
        print("reg has been failed");
        print(result.affectedRows);
      }
    } else {
      late Results result;

      try {
        result = await _connection.query(
          'INSERT INTO servicemen (email, password, name) VALUES (?, ?, ?)',
          [email, password, name],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'INSERT INTO servicemen (email, password, name) VALUES (?, ?, ?)',
          [email, password, name],
        );
      }
      if (result.affectedRows == 1) {
        // Registration successful
        print("success reg");
      } else {
        // Registration failed
        print("reg has been failed");
        print(result.affectedRows);
      }
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<bool> loginUser(String email, String password, String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userType == 'consumer') {
      late Results result;
      try {
        result = await _connection.query(
          'SELECT email FROM consumer WHERE email = ? AND password = ?',
          [email, password],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'SELECT email FROM consumer WHERE email = ? AND password = ?',
          [email, password],
        );
      }
      await prefs.setString('email', email);
      return result.isNotEmpty;
    } else {
      late Results result;
      try {
        result = await _connection.query(
          'SELECT email FROM servicemen WHERE email = ? AND password = ?',
          [email, password],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'SELECT email FROM servicemen WHERE email = ? AND password = ?',
          [email, password],
        );
      }

      await prefs.setString('email', email);

      log("User has been logged : + ${result.isNotEmpty}");
      return result.isNotEmpty;
    }
  }

  Future<Results> fetchProfile(String email, String userType) async {
    if (userType == 'consumer') {
      late Results result;
      print("fetching");

      try {
        result = await _connection.query(
          'SELECT name,email,password,dob,address FROM consumer WHERE email = ?',
          [email],
        );
        // databaseManager.close();
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        // await _connection.query(
        //   'SELECT name,email,password,dob,address FROM consumer WHERE email = ?',
        //   [email],
        // );
        result = await _connection.query(
          'SELECT name,email,password,dob,address FROM consumer WHERE email = ?',
          [email],
        );
      }

      return result;
    } else {
      late Results result;

      try {
        result = await _connection.query(
          'SELECT name,email,password,dob,address FROM servicemen WHERE email = ?',
          [email],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'SELECT name,email,password,dob,address FROM servicemen WHERE email = ?',
          [email],
        );
      }
      print("got details");
      return result;
    }
  }

  Future<void> setDetails(String email, String userType, String name,
      String password, String dob, String location) async {
    if (userType == 'consumer') {
      try {
        await _connection.query(
          'update consumer set name = ?,password = ? ,dob = ?,address = ? where email = ?',
          [name, password, dob, location, email],
        );
        // databaseManager.close();
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        await _connection.query(
          'update consumer set name = ?,password = ? ,dob = ?,address = ? where email = ?',
          [name, password, dob, location, email],
        );
      }
    } else {
      try {
        await _connection.query(
          'update servicemen set name = ?,password = ? ,dob = ?,address = ? where email = ?',
          [name, password, dob, location, email],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        await _connection.query(
          'update servicemen set name = ?,password = ? ,dob = ?,address = ? where email = ?',
          [name, password, dob, location, email],
        );
      }
    }
    print("set success");
  }
}
