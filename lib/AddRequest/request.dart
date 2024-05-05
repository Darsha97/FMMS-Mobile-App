// import 'package:flutter/material.dart';
// import 'package:fmms/Services/dataBase.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:random_string/random_string.dart';
// import 'package:fmms/HomePage/homepage.dart';

// class RequestPage extends StatefulWidget {
//   final ScrollController controller;

//   RequestPage({required this.controller});

//   @override
//   State<RequestPage> createState() => _RequestPageState();
// }

// class _RequestPageState extends State<RequestPage> {
//   TextEditingController placeController = TextEditingController();
//   TextEditingController issueTypeController = TextEditingController();
//   TextEditingController priorityController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String? _selectedPlace;
//   List<String> _place = ['Place 1', 'Place 2', 'Place 3'];
//   String? _selectedIssue;
//   List<String> _issueType = ['type 1', 'type 2', 'type 3'];
//   String? _selectedPriority;
//   List<String> _priority = ['High', 'Medium', 'Low'];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Request Form'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Place'),
//                     value: _selectedPlace,
//                     items: _place.map((value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedPlace = newValue;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a place';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 5), // Reduced SizedBox height
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Issue Type'),
//                     value: _selectedIssue,
//                     items: _issueType.map((value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedIssue = newValue;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select an issue type';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 5), // Reduced SizedBox height
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Priority'),
//                     value: _selectedPriority,
//                     items: _priority.map((value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedPriority = newValue;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a priority';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 5), // Reduced SizedBox height
//                   TextFormField(
//                     controller: descriptionController,
//                     decoration: InputDecoration(labelText: 'Description'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a description';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20), // Reduced SizedBox height
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         String Id = randomAlphaNumeric(10);
//                         Map<String, dynamic> requestInfoMap = {
//                           "Place": _selectedPlace,
//                           "Issue Type": _selectedIssue,
//                           "Priority": _selectedPriority,
//                           "Id": Id,
//                           "Description": descriptionController.text,
//                         };
      
//                         await DatabaseMethods()
//                             .addRequestDetails(requestInfoMap, Id)
//                             .then((value) {
//                           Fluttertoast.showToast(
//                             msg: "Request saved successfully",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.CENTER,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: Colors.red,
//                             textColor: Colors.white,
//                             fontSize: 16.0,
//                           );
      
//                           Navigator.pop(context);
//                         });
//                       }
//                     },
//                     child: Text(
//                       "Add Request",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: const Color(0xFFfeba02),
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         side: BorderSide(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.request_page),
//                 label: 'Requests',
//               ),
//             ],
//             currentIndex: 1, // Adjust the index based on the current page
//             selectedItemColor: Colors.blue,
//             onTap: (index) {
//               // Handle navigation based on the selected tab
//               if (index == 0) {
//                 // Navigate to the Home page
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HomeScreen(controller: widget.controller),
//                   ),
//                 );
//               }
//               // Add more navigation logic for other tabs if needed
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fmms/Services/dataBase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:fmms/HomePage/homepage.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package

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
  List<String> _place = ['library', 'LT1', 'Auditorium','Hostal A'];
  String? _selectedIssue;
  List<String> _issueType = ['Electrical', 'Water Leak', 'Furniture'];
  String? _selectedPriority;
  List<String> _priority = ['High', 'Medium', 'Low'];

  // Define the getImage method to pick an image from gallery
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

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => HomeScreen(controller: ScrollController()),
  ),
);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: const Text(
          'Request Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
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
                  SizedBox(height: 5), // Reduced SizedBox height
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
                  SizedBox(height: 5), // Reduced SizedBox height
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
                  SizedBox(height: 5), // Reduced SizedBox height
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
                  SizedBox(height: 20), // Reduced SizedBox height
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
                  SizedBox(height: 20), // Reduced SizedBox height
                  if (_image != null) // Show the image if it's selected
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.file(_image!),
                    ),
                  SizedBox(height: 20), // Reduced SizedBox height
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String Id = randomAlphaNumeric(10);
                        Map<String, dynamic> requestInfoMap = {
                          "Place": _selectedPlace,
                          "Issue Type": _selectedIssue,
                          "Priority": _selectedPriority,
                          "Id": Id,
                          "Description": descriptionController.text,
                          "Image": _image != null ? _image!.path : null, // Add image path to the request info map
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
                      "Add Request",
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: BottomAppBar(
          child: BottomNavigationBar(
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
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add),
                label: 'Notification',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
                // Navigate to the home screen if the "Home" icon is clicked
                if (_selectedIndex == 0) {
                  // Create a ScrollController if needed
                  ScrollController controller = ScrollController();
                  // Navigate to the HomePage screen using pushReplacement and provide the required ScrollController
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(controller: controller)),
                  );
                }
              });
            },
          ),
        ),
      ),
      
    ),
      );
    
  }
}
