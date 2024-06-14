import 'package:flutter/material.dart';
import 'package:fmms/HomePage/homepage.dart';
import 'package:fmms/HomePage/OngoingRequest.dart';
import 'package:fmms/HomePage/Note.dart';

class Note extends StatelessWidget {
  const Note({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Notifications',
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
                    splashColor: Colors.grey, // Color when pressed
                    highlightColor: Colors.transparent, // No highlight color
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
