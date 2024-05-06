import 'dart:developer';
import 'package:fmms/models/maintenanceRequest.dart';

class User {
  final Object id;
  final String fullName;
  final String email;
  final String regNo;
  final String password;
  final String confirmPassword;
  final String? contactNumber;
  final String role;
  final String? department;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.regNo,
    required this.password,
    required this.confirmPassword,
    this.contactNumber,
    required this.role,
    this.department,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      regNo: json['regNo'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      contactNumber: json['contactNumber'],
      role: json['role'],
      department: json['department'],
    );
  }

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
    };
  }
}
