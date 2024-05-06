import 'package:fmms/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';

class MongoDatabase {
  static Db? db;
  static final String userCollectionName = 'users';

  static Future<void> connect() async {
    try {
      db = await Db.create(
          'mongodb+srv://facultymaintenance:fmms123@fmms.zwouah7.mongodb.net/?retryWrites=true&w=majority');
      await db!.open();
      inspect(db);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> close() async {
    try {
      await db!.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // Function to handle user login
  static Future<bool> login(String username, String password) async {
    var userCollection = db!.collection(userCollectionName);
    var user =
        await userCollection.findOne({'regNo': username, 'password': password});
    return user != null;
  }

  static Future<String> insert(User data) async {
    try {
      var userCollection = db!.collection(userCollectionName);
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "SignUp Sucessfull";
      } else {
        return "SignUp Failed.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
