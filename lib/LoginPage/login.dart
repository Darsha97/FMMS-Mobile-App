import 'package:flutter/material.dart';
import 'package:fmms/LoginPage/signup.dart';
import 'package:fmms/HomePage/homepage.dart';

class LoginPage extends StatefulWidget {
  
  final PageController controller;
  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyAppState();
}

class _MyAppState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              SizedBox(height: 20,),

              Text('Login',style: TextStyle(
                fontSize: 35, 
                color:Colors.blue,
                fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 20,),
              
               Image.asset(
                'assets/image.png', // replace with your actual image path
                height: 150, // adjust the height as needed
              ),
              SizedBox(height: 20,),
              
              Padding(
                padding: const EdgeInsets.all(30),
                child: Form(child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        hintText: 'Enter User Name',
                        border: OutlineInputBorder(  
                              borderRadius:BorderRadius.all(Radius.circular(15))
                             ),
                      ),
                      onChanged: (String value) {
                        
                      },
                      validator: (value) {
                        return value!.isEmpty? 'Please enter user name' : null;
                      },
                    ),
                
                    SizedBox(height: 30,),
                
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(15))),
                      ),
                      onChanged: (String value) {
                        
                      },
                      validator: (value) {
                        return value!.isEmpty? 'Please enter password' : null;
                      },
                    ),
          
                    SizedBox(height: 30,),

                    ElevatedButton(
                      onPressed:(){
                        // Navigate to the HomePage
                        Navigator.pushReplacement(
                          context,
                           MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(controller: widget.controller),
                                ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
    primary: Colors.green, // Set the button color here
  ),
                      child: Text('Login',style: TextStyle(
                   
                      color:Colors.black,
                      fontWeight: FontWeight.bold
                ),),
                       
                    ),
                      SizedBox(height: 20,),
                      
                      Row(
                        children: [
                          const Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 2.5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage(
                                        controller: widget.controller)),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF003580),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Color(0xFF003580),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                  ],)
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}