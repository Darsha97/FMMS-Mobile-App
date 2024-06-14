import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId id;
  String fullName;
  String email;
  String regNo;
  String password;
  String confirmPassword;
  String contactNumber;
  String role;
  String department;
  String status;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.regNo,
    required this.password,
    required this.confirmPassword,
    required this.contactNumber,
    required this.role,
    required this.department,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'regNo': regNo,
      'password': password,
      'confirmPassword': confirmPassword,
      'contactNumber': contactNumber,
      'role': role,
      'department': department,
      'status': status,
    };
  }
}
