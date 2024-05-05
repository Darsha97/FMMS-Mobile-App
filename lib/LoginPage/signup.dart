import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
   final PageController controller;
   const SignupPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String? _departmentvalue;
  List<String> _Departmets= ['Civil','Electrical','Mechanical'];
  String? _rolevalue;
  List<String> _roles= ['Student','Lecturer','Admin'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('SignUp',style: TextStyle(
                  fontSize: 30, 
                  color:Colors.blue,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10, horizontal:20),
                child: Form(child: SizedBox( width: double.infinity,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter Full Name',
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(5))
                          ),
                          contentPadding:EdgeInsets.all(15),
                          
                        ),
                        onChanged: (String value) {
                          
                        },
                        validator: (value) {
                          return value!.isEmpty? 'Please enter user name' : null;
                        },
                      ),
                  
                      SizedBox(height: 30,),
                  
                        TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Reg No',
                          hintText: 'Enter Reg No',
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(5))
                          ),
                          contentPadding:EdgeInsets.all(15),
                        ),
                        onChanged: (String value) {
                          
                        },
                        validator: (value) {
                          return value!.isEmpty? 'Please enter user name' : null;
                        },
                      ),
                  
                      SizedBox(height: 30,),
                  
                        TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter email',
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(5))
                          ),
                          contentPadding:EdgeInsets.all(15),
                        ),
                        onChanged: (String value) {
                          
                        },
                        validator: (value) {
                          return value!.isEmpty? 'Please enter user name' : null;
                        },
                      ),
                  
                      SizedBox(height: 30,),
                  
                        SizedBox(height:50,
                          child: DropdownButtonFormField<String>(
                          value:_rolevalue,
                          decoration: InputDecoration(
                            labelText: 'Role',
                            hintText: 'Enter Role',
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(5))
                            ),
                            contentPadding:EdgeInsets.all(15),
                          ),
                         
                          onChanged: (value) {
                            setState(() {
                              _rolevalue=value??'';
                            });
                            
                          },
                          validator: (value) {
                          return value!.isEmpty? 'Please enter user name' : null;
                        },
                          items: _roles.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child:Text(value),);
                          }).toList()
                          
                                                ),
                        ),
                  
                      SizedBox(height: 30,),
                        
                        SizedBox(height:50,
                          child: DropdownButtonFormField<String>(
                          value:_departmentvalue,
                          decoration: InputDecoration(
                            labelText: 'Department',
                            hintText: 'Enter Department',
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(5))
                            ),
                            contentPadding:EdgeInsets.all(15),
                          ),
                         
                          onChanged: (value) {
                            setState(() {
                              _departmentvalue=value??'';
                            });
                            
                          },
                          validator: (value) {
                          return value!.isEmpty? 'Please enter user name' : null;
                        },
                          items: _Departmets.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child:Text(value),);
                          }).toList()
                          
                                                ),
                        ),
                  
                      SizedBox(height: 30,),
                  
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(5))
                          ),
                          contentPadding:EdgeInsets.all(15),
                        ),
                        onChanged: (String value) {
                          
                        },
                        validator: (value) {
                          return value!.isEmpty? 'Please enter password' : null;
                        },
                      ),
                  
                      SizedBox(height: 30,),
                  
                      MaterialButton(
                        onPressed:(){},
                        child: Text('SignUp'),
                        color: Colors.teal,
                        textColor:Colors.white,
                        )
                    ],),
                )
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}