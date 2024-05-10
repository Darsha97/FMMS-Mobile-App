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

  static Future<String?> login(String username, String password) async {
    try {
      // Ensure that the database connection is established
      if (db == null) {
        await connect();
      }

      var userCollection = db!.collection(userCollectionName);
      var user = await userCollection
          .findOne({'regNo': username, 'password': password});

      if (user != null) {
        // Return the userId if the user exists
        return user['_id']
            .toString(); // Assuming '_id' is the field containing the userId
      } else {
        // Return null if the user does not exist or the credentials are incorrect
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null; // Return null in case of any error
    }
  }

  static Future<String> insert(User data) async {
    try {
      // Ensure that the database connection is established
      if (db == null) {
        await connect();
      }

      var userCollection = db!.collection(userCollectionName);
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Sign Up Successful";
      } else {
        return "Sign Up Failed.";
      }
    } catch (e) {
      print(e.toString());
      return "Sign Up Failed.";
    }
  }

  static Future<List<Map<String, dynamic>>> getRequestDetailsByUser(
      String userId) async {
    try {
      if (db == null) {
        await connect();
      }

      var requests = await db!
          .collection('maintenance_requests')
          .find(where.eq('submittedBy', userId))
          .toList();

      return requests
          .map((request) => request as Map<String, dynamic>)
          .toList();
    } catch (e) {
      log(e.toString());
      return [];
    } finally {
      if (db != null) {
        await db!.close();
      }
    }
  }

  static Future<String?> getUserId(String email) async {
    try {
      final db = Db(
          'mongodb+srv://facultymaintenance:fmms123@fmms.zwouah7.mongodb.net/?retryWrites=true&w=majority');
      await db.open();

      final userCollection = db.collection('users');
      final user = await userCollection.findOne(where.eq('email', email));

      await db.close();

      if (user != null) {
        return user['_id'].toString();
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user ID: $e');
      return null;
    }
  }
}
