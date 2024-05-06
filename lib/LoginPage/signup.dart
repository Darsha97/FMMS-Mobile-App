import 'package:flutter/material.dart';
import 'package:fmms/models/user.dart';
import 'package:fmms/LoginPage/login.dart';
import 'package:fmms/models/maintenanceRequest.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:fmms/mongodb.dart' as fmms;

class SignupPage extends StatefulWidget {
  final PageController controller;
  const SignupPage({Key? key, required this.controller}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  String? _roleValue;
  String? _departmentValue;

  Future<void> _signUp(
    String fullName,
    String email,
    String regNo,
    String password,
    String confirmPassword,
    String contactNumber,
    String role,
    String department,
  ) async {
    var _id = mongo.ObjectId();

    final data = User(
      id: _id,
      fullName: fullName,
      email: email,
      regNo: regNo,
      password: password,
      confirmPassword: confirmPassword,
      contactNumber: contactNumber,
      role: role,
      department: department,
    );

    var result = await fmms.MongoDatabase.insert(data);

    if (result != null && result is String) {
      // If data insertion is successful, navigate to LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  controller: widget.controller,
                )),
      );
    } else {
      // Handle insertion failure here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add data to the database.'),
        ),
      );
    }

    _clearAll();
  }

  void _clearAll() {
    _fullNameController.text = "";
    _emailController.text = "";
    _regNoController.text = "";
    _passwordController.text = "";
    _confirmPasswordController.text = "";
    _contactNumberController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _regNoController,
              decoration: InputDecoration(labelText: 'Registration No.'),
            ),
            DropdownButtonFormField<String>(
              value: _roleValue,
              onChanged: (value) {
                setState(() {
                  _roleValue = value;
                });
              },
              items: ['Student', 'Lecturer', 'Admin']
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Role',
                hintText: 'Select Role',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            DropdownButtonFormField<String>(
              value: _departmentValue,
              onChanged: (value) {
                setState(() {
                  _departmentValue = value;
                });
              },
              items: ['Civil', 'Electrical', 'Mechanical']
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Department',
                hintText: 'Select Department',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            TextField(
              controller: _contactNumberController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _signUp(
                  _fullNameController.text,
                  _emailController.text,
                  _regNoController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                  _contactNumberController.text,
                  _roleValue!,
                  _departmentValue!,
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
