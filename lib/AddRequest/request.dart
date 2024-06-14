import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fmms/Services/dataBase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:fmms/HomePage/homepage.dart';
import 'package:image_picker/image_picker.dart';

class RequestPage extends StatefulWidget {
  final ScrollController controller;

  RequestPage({required this.controller});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController placeController = TextEditingController();
  TextEditingController issueTypeController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? _image;
  int _selectedIndex = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedPlace;
  List<String> _place = ['library', 'LT1', 'Auditorium', 'Hostel A'];
  String? _selectedIssue;
  List<String> _issueType = ['Electrical', 'Water Leak', 'Furniture'];
  String? _selectedPriority;
  List<String> _priority = ['High', 'Medium', 'Low'];

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Stack(children:[
          Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 160, // Adjust the height according to your needs
              child: Image.asset("assets/draw2.jpg"), // Replace with your image
            ),
           SizedBox(height:0),

          SingleChildScrollView(
            child: Padding(
             

              padding: const EdgeInsets.symmetric(vertical:40, horizontal: 20),
              child: Container( margin: EdgeInsets.only(top: 118),decoration: BoxDecoration(
               
              color: Colors.grey[200], // Set background color of the frame
              borderRadius: BorderRadius.circular(10), // Set border radius
              boxShadow: [
                BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Set shadow color
          spreadRadius: 5, // Set spread radius
          blurRadius: 7, // Set blur radius
          offset: Offset(0, 3), // Set shadow offset
                ),
              ],
            ),
              
             padding: EdgeInsets.symmetric(vertical: 10, horizontal:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 0),
                    Text(
                      'Add Your Request',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(labelText: 'Place'),
                            value: _selectedPlace,
                            items: _place.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedPlace = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a place';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(labelText: 'Issue Type'),
                            value: _selectedIssue,
                            items: _issueType.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedIssue = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an issue type';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(labelText: 'Priority'),
                            value: _selectedPriority,
                            items: _priority.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedPriority = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a priority';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(labelText: 'Description'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: getImage,
                            child: Row(
                              children: [
                                Icon(Icons.attach_file, color: Colors.blue),
                                SizedBox(width: 10),
                                Text(
                                  "Attach Image",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          if (_image != null)
                            Container(
                              height: 200,
                              width: double.infinity,
                              child: Image.file(_image!),
                            ),
                          SizedBox(height: 0),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 100.0),
                            child: ElevatedButton(
                              
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  String Id = randomAlphaNumeric(10);
                                  Map<String, dynamic> requestInfoMap = {
                                    "Place": _selectedPlace,
                                    "Issue Type": _selectedIssue,
                                    "Priority": _selectedPriority,
                                    "Id": Id,
                                    "Description": descriptionController.text,
                                    "Image": _image != null ? _image!.path : null,
                                  };
                            
                                  await DatabaseMethods()
                                      .addRequestDetails(requestInfoMap, Id)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                      msg: "Request saved successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                            
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: const Color(0xFFfeba02),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          
                
              ),
            ),
          ),
        ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF003580),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          iconSize: 20,
          selectedFontSize: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page),
              label: 'Requests',
            ),
             
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(controller: widget.controller),
          ),
        );
      }
    });
  }
}
