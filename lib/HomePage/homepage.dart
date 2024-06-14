import 'package:flutter/material.dart';
import 'package:fmms/Services/dataBase.dart';
import 'package:fmms/AddRequest/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
 
import 'package:fmms/HomePage/OngoingRequest.dart';
import 'package:fmms/HomePage/Note.dart';
import 'package:fmms/LoginPage/login.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController controller;

  HomeScreen({required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController placeController = TextEditingController();
  TextEditingController issueTypeController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Stream? reservationStream;
  int _selectedIndex = 0;

   
  String? _selectedPlace;
  List<String> _place = ['library', 'LT1', 'Auditorium','Hostal A'];
  String? _selectedIssue;
  List<String> _issueType = ['Electrical', 'Water Leak', 'Furniture'];
  String? _selectedPriority;
  List<String> _priority = ['High', 'Medium', 'Low'];


  getOnLoad() async {
    reservationStream = await DatabaseMethods().getRequestDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnLoad();
    super.initState();
  }

  static List<Widget> _widgetOptions(BuildContext context, String description) {
    return [
      Text('Home'),
      Text('Requests'),
      Text(description),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => RequestPage(controller: ScrollController()),
  ),
);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(controller: PageController())),
            );
          },
        ),
      ),

        
        
      
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
       Container(
  decoration: BoxDecoration(
    color: Colors.grey[400], // Background color of the container
    borderRadius: BorderRadius.circular(10.0), // Rounded corners for the container
  ),
  padding: EdgeInsets.all(10.0), // Padding around the container
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons evenly in the row
    children: [
      IconButton(
       onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(controller: ScrollController())),
    );
  },
        icon: Text('Maintenance Request'),
        tooltip: 'Maintenance Request',
        color: Colors.black, // Color of the button
        //iconColor: Colors.white, // Color of the icon
        splashColor: Colors.grey, // Color when pressed
        highlightColor: Colors.transparent, // No highlight color
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OngoingRequest()),
          );
        },
        icon: Text('Ongoing Requests'),
        tooltip: 'Ongoing Requests',
        color: Colors.green, // Color of the button
        //iconColor: Colors.white, // Color of the icon
        splashColor: Colors.grey, // Color when pressed
        highlightColor: Colors.transparent, // No highlight color
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note()),
          );
        },
        icon: Text('Notifications'),
        tooltip: 'Notifications',
        color: Colors.orange, // Color of the button
        //iconColor: Colors.white, // Color of the icon
        splashColor: Colors.grey, // Color when pressed
        highlightColor: Colors.transparent, // No highlight color
      ),
    ],
  ),
),


          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: kToolbarHeight + 10.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Expanded(
                  child: allRequestDetails(),
                ),
                SizedBox(height: 70,),
              ],
            ),
          ),
          Positioned(
            top: 10.0, 
            left: 100,
            right: 100,
            child: Center(
              
            ),
          ),
        ],
      ),
      bottomNavigationBar: PreferredSize(preferredSize: Size.fromHeight(5.0),
        child: BottomAppBar(
           
         
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFF003580),
              selectedItemColor:Colors.white,
              unselectedItemColor:Colors.white70,
              iconSize: 20,
              selectedFontSize: 10,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
            
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.request_page),
                  label: 'Add Request',
                ),
                //  BottomNavigationBarItem(
                //   icon: Icon(Icons.notification_add),
                //   label: 'Notification',
                // ),
                
              ],
              currentIndex: _selectedIndex,
               
              onTap: _onItemTapped,
            ),
          ),
        ),
      
    );
  }

Future<void> EditRequestDetail(String id) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              "Place",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            DropdownButtonFormField<String>(
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
            ),
            SizedBox(height: 10.0),
            Text(
              "Issue Type",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            DropdownButtonFormField<String>(
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
            ),
            SizedBox(height: 10.0),
            Text(
              "Priority",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            DropdownButtonFormField<String>(
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
            ),
            SizedBox(height: 10.0),
            Text(
              "Description",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFfeba02),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black),
                  ),          
                ),
                onPressed: () async {
                    Map<String, dynamic> updateInfo = {
                      "Place": _selectedPlace,
                      "Issue Type": _selectedIssue,
                      "Priority": _selectedPriority,
                      "Description": descriptionController.text,
                      "Id": id,
                    };
                    await DatabaseMethods()
                        .updateRequestDetails(updateInfo, id)
                        .then((value) {
                          Fluttertoast.showToast(
                        msg: "Request has been updated sucessfuly",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                      Navigator.pop(context);
                    });
                },
                child: Text("Update",
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);



  Widget allRequestDetails() {
    return StreamBuilder(
      stream: reservationStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.black, 
                            width: 2.0, 
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            _buildDataRow("Description", ds["Description"]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    descriptionController.text = ds["Description"];
                                    EditRequestDetail(ds["Id"]);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: const Color(0xFF003580),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                GestureDetector(
                                  onTap: () async {
                                    await DatabaseMethods().deleteRequestDetails(ds["Id"]);
                                    Fluttertoast.showToast(
                                      msg: "Request has been deleted successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: const Color(0xFF003580),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(); // Return an empty container or a loading indicator when there is no data
      },
    );
  }

  Widget _buildDataRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            child: Text(
              "$label",
              style: TextStyle(
                color: const Color(0xFF003580),
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              value ?? 'N/A', // If value is null, display 'N/A'
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
