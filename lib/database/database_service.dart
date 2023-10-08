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
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString('person', userType);
  }

  Future<bool> loginUser(String email, String password, String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userType == 'consumer') {
      late Results result;
      try {
        result = await _connection.query(
          'SELECT email,name FROM consumer WHERE email = ? AND password = ?',
          [email, password],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'SELECT email,name FROM consumer WHERE email = ? AND password = ?',
          [email, password],
        );
      }

      bool isReg = result.isNotEmpty;
      if (isReg) {
        await prefs.setString('email', email);
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString('person', userType);
        await prefs.setString('name', result.first.values![1].toString());
      }

      print(prefs.getBool("isLoggedIn"));
      return isReg;
    } else {
      late Results result;
      try {
        result = await _connection.query(
          'SELECT email,name FROM servicemen WHERE email = ? AND password = ?',
          [email, password],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'SELECT email,name FROM servicemen WHERE email = ? AND password = ?',
          [email, password],
        );
      }

      bool isReg = result.isNotEmpty;
      if (isReg) {
        await prefs.setString('email', email);
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString('person', userType);
        await prefs.setString('name', result.first.values![1].toString());
      }

      log("User has been logged : + ${result.isNotEmpty}");
      return isReg;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', '');
    await prefs.setBool("isLoggedIn", false);
    await prefs.setString('person', '');
    await prefs.setString('name', "");
    log("logged out");
  }

  Future<Results> fetchProfile(String email, String userType) async {
    if (userType == 'consumer') {
      late Results result;
      print("fetching");

      try {
        result = await _connection.query(
          'SELECT name,email,password,dob,address,gender,contactNumber FROM consumer WHERE email = ?',
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
          'SELECT name,email,password,dob,address,gender,contactNumber FROM consumer WHERE email = ?',
          [email],
        );
      }

      return result;
    } else {
      late Results result;

      try {
        result = await _connection.query(
          'SELECT email,address,dob ,name,gender,contactNumber,password,experience,available FROM servicemen WHERE email = ?',
          [email],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        result = await _connection.query(
          'SELECT email,address,dob ,name,gender,contactNumber,password,experience,available FROM servicemen WHERE email = ?',
          [email],
        );
      }
      print("got details");
      return result;
    }
  }

  Future<void> setDetails(
      String email,
      String userType,
      String name,
      String password,
      String dob,
      String location,
      String gender,
      String contact,
      String experience,
      String available) async {
    if (userType == 'consumer') {
      try {
        print(gender);

        await _connection.query(
          'update consumer set name = ?,password = ? ,dob = ?,address = ?, gender = ?,contactNumber = ? where email = ?',
          [name, password, dob, location, gender, contact, email],
        );
        // databaseManager.close();
      } catch (e) {
        print(gender);
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        await _connection.query(
          'update consumer set name = ?,password = ? ,dob = ?,address = ?, gender = ?,contactNumber = ? where email = ?',
          [name, password, dob, location, gender, contact, email],
        );
      }
    } else {
      try {
        await _connection.query(
          'update servicemen set name = ?,password = ? ,dob = ?,address = ?, gender = ?,contactNumber = ?,experience = ? ,available= ? where email = ?',
          [
            name,
            password,
            dob,
            location,
            gender,
            contact,
            experience,
            available,
            email
          ],
        );
      } catch (e) {
        print(e);
        print("reinit database");
        await databaseManager.initialize();
        _connection = DatabaseManager().connection;
        await _connection.query(
          'update servicemen set name = ?,password = ? ,dob = ?,address = ?, gender = ?,contactNumber = ?,experience = ? ,available= ? where email = ?',
          [
            name,
            password,
            dob,
            location,
            gender,
            contact,
            experience,
            available,
            email
          ],
        );
      }
    }
    print("set success");
  }

  Future<Results> fetchServicemenData() async {
    late Results result;
    print("fetching servicemen data");

    try {
      result = await _connection.query(
        'SELECT name,email,dob,address,gender,contactNumber,experience,rating,available FROM servicemen',
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
        'SELECT name,email,dob,address,gender,contactNumber,experience,rating,available FROM servicemen',
      );
    }

    return result;
  }

  Future<Results> fetchServiceData() async {
    late Results result;
    print("fetching service data");

    try {
      result = await _connection.query(
        'SELECT ServiceId FROM services',
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
        'SELECT ServiceId FROM services',
      );
    }

    // print(result);
    // print("working");

    return result;
  }

  Future<Results> fetchSubServiceData(var serviceId) async {
    late Results result;
    print("fetching subservice data");

    try {
      result = await _connection.query(
        'SELECT subservice,servicename,description,price FROM subservice WHERE serviceId = ?',
        [serviceId],
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
        'SELECT subservice,servicename,description,price FROM subservice WHERE serviceId = ?',
        [serviceId],
      );
    }

    return result;
  }

  Future<List<String>> fetchTags(String email) async {
    late Results result;
    List<String> tags = [];

    try {
      result = await _connection.query(
        'SELECT tag FROM tags where email = ?',
        [email],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      result = await _connection.query(
        'SELECT tag FROM tags where email = ?',
        [email],
      );
    }

    for (int i = 0; i < result.length; i++) {
      tags.add(result.elementAt(i).elementAt(0).toString());
    }
    print(tags);
    return tags;
  }

  Future<Results> SearchService(String servicename) async {
    late Results result;

    try {
      result = await _connection.query(
        'SELECT subservice,servicename,description,price FROM subservice WHERE servicename = ?',
        [servicename],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      result = await _connection.query(
        'SELECT subservice,servicename,description,price FROM subservice WHERE servicename = ?',
        [servicename],
      );
    }
    return result;
  }

  Future<bool> addToCart(
      String email, String serviceId, String subserviceId) async {
    try {
      await _connection.query(
        'insert into cart (consumerEmail ,serviceId , subservice) values (?,?,?) ',
        [email, serviceId, subserviceId],
      );
      return true;
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;

      await _connection.query(
        'insert into cart (consumerEmail ,serviceId , subservice) values (?,?,?) ',
        [email, serviceId, subserviceId],
      );
      return false;
    }
  }

  Future<List<Results>> fetchCart(String email) async {
    late Results result;
    late String serviceID;
    late String subservice;
    late Results results2;
    try {
      result = await _connection.query(
        'select serviceId,subservice from cart where consumerEmail  = ?',
        [email],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      result = await _connection.query(
        'select serviceId,subservice from cart where consumerEmail  = ?',
        [email],
      );
    }

    List<Results> resultList = [];
    for (int i = 0; i < result.length; i++) {
      serviceID = result.elementAt(i).values![0].toString();
      subservice = result.elementAt(i).values![1].toString();
      resultList.add(await fetchServiceDetails(serviceID, subservice));
    }

    return resultList;
  }

  Future<Results> fetchServiceDetails(
      String serviceID, String subservice) async {
    late Results results;

    try {
      results = await _connection.query(
        'select servicename,description,price,serviceId,subservice from subservice where ( serviceId = ? ) AND ( subservice = ? )',
        [serviceID, subservice],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      results = await _connection.query(
        'select servicename,description,price,serviceId,subservice  from subservice where ( serviceId = ? ) AND ( subservice = ? )',
        [serviceID, subservice],
      );
    }

    return results;
  }

  Future<bool> deleteCart(
      String email, String serviceID, String subserviceId) async {
    late Results results;

    try {
      results = await _connection.query(
        'delete from cart where ( serviceId = ? ) AND ( subservice = ? ) AND ( consumerEmail = ?) ',
        [serviceID, subserviceId, email],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      results = await _connection.query(
        'delete from cart where ( serviceId = ? ) AND ( subservice = ? ) AND ( consumerEmail = ?) ',
        [serviceID, subserviceId, email],
      );
    }

    return results.affectedRows == 0 ? false : true;
  }

  Future<bool> addToOrders(
    String consumerEmail,
    String bookingDate,
    String serviceId,
    String subservice,
  ) async {
    late Results results;

    // we are only having three status - pending - in progress - completed.
    // After completion there will be the review time if needed.

    try {
      results = await _connection.query(
        'insert into orderList (serviceId,subservice,orderStatus,bookingDate,servicemenEmail,consumerEmail) values (?,?,?,?,?,?) ',
        [serviceId, subservice, "pending", bookingDate, "", consumerEmail],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      results = await _connection.query(
        'insert into orderList (serviceId,subservice,orderStatus,bookingDate,servicemenEmail,consumerEmail) values (?,?,?,?,?,?) ',
        [serviceId, subservice, "pending", bookingDate, "", consumerEmail],
      );
    }

    return results.affectedRows == 0 ? false : true;
  }

  Future<Map<ResultRow, Results>> fetchOrders(
      String email, String status) async {
    late Results result;
    late String serviceID;
    late String subservice;

    try {
      result = await _connection.query(
        'select serviceId,subservice,orderStatus,bookingDate,servicemenEmail from orderList where consumerEmail  = ? and (orderStatus = ? or orderStatus = ?)',
        [email, status.split("|").first, status.split("|")[1]],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      result = await _connection.query(
        'select serviceId,subservice,orderStatus,bookingDate,servicemenEmail from orderList where consumerEmail  = ? and orderStatus = ?',
        [email, status],
      );
    }

    Map<ResultRow, Results> map = {};
    for (int i = 0; i < result.length; i++) {
      serviceID = result.elementAt(i).values![0].toString();
      subservice = result.elementAt(i).values![1].toString();
      Results r = await fetchServiceDetails(serviceID, subservice);
      map.putIfAbsent(result.elementAt(i), () => r);
    }

    return map;
  }

  Future<String> fetchServicemenName(String email) async {
    late Results results;

    try {
      results = await _connection.query(
        'select name from servicemen where email = ?',
        [email],
      );
    } catch (e) {
      print(e);
      print("reinit database");
      await databaseManager.initialize();
      _connection = DatabaseManager().connection;
      results = await _connection.query(
        'select name from servicemen where email = ?',
        [email],
      );
    }
    return results.first.values![0].toString();
  }
}
