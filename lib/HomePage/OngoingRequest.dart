import 'package:flutter/material.dart';
import 'package:fmms/HomePage/homepage.dart';
import 'package:fmms/HomePage/OngoingRequest.dart';
import 'package:fmms/HomePage/Note.dart';

class OngoingRequest extends StatelessWidget {
  const OngoingRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Ongoing Requests',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400], // Background color of the container
                borderRadius: BorderRadius.circular(10.0), // Rounded corners for the container
              ),
              padding: EdgeInsets.all(10.0), // Padding around the container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons evenly in the row
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(controller: ScrollController()),
                        ),
                      );
                    },
                    child: Text('Maintenance Request'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Background color of the button
                      onPrimary: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OngoingRequest(),
                        ),
                      );
                    },
                    child: Text('Ongoing Requests'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color of the button
                      onPrimary: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Note(),
                        ),
                      );
                    },
                    child: Text('Notifications'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // Background color of the button
                      onPrimary: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
