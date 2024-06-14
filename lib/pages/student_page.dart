import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // for accessing useLocation()
import 'package:fluttertoast/fluttertoast.dart'; // for toast notifications
import 'package:http/http.dart' as http; // for making HTTP requests
import 'dart:convert'; // for handling JSON data

//import 'maintenance_requests.dart'; // Import your custom widgets
// import 'student_ongoing_maintenance.dart'; // Import your custom widgets
// import 'student_notifications.dart'; // Import your custom widgets

class StudentPage extends StatefulWidget {
   final String id;

  StudentPage({Key? key, required this.id}) : super(key: key);
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String activeTab = 'maintenanceRequests'; // Default active tab
  String userId = ''; // Placeholder for user ID

  @override
  void initState() {
    super.initState();
    // Fetch user ID from route or location
    fetchUserId();
  }

  // Fetch user ID from route or location (simulated)
  void fetchUserId() {
    // Simulated location data
    String locationPathname = '/student/123'; // Replace with actual route or location logic
    userId = locationPathname.split('/').last;
  }

  void setActiveTab(String tab) {
    setState(() {
      activeTab = tab;
    });
  }

  void toggleSidebar() {
    // Implement sidebar toggle logic if needed
    // Typically, Flutter uses Drawer or BottomNavigationBar for navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Sidebar
            Container(
              width: 250, // Adjust sidebar width as needed
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey)),
              ),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Text('Home'),
                      onTap: () {
                        // Implement navigation logic
                      },
                    ),
                    ListTile(
                      title: Text('Calendar'),
                      onTap: () {
                        // Implement navigation logic
                      },
                    ),
                    ListTile(
                      title: Text('Contact'),
                      onTap: () {
                        // Implement navigation logic
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Navigation Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: toggleSidebar,
                        ),
                        Text(
                          'Welcome to Student Dashboard',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    // Tabs
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildTab('Maintenance Requests', 'maintenanceRequests'),
                        buildTab('Ongoing Maintenance', 'ongoingMaintenance'),
                        buildTab('Notifications', 'notifications'),
                      ],
                    ),

                    // Tab Content
                    SizedBox(height: 16),
                    Expanded(
                      child: IndexedStack(
                        index: activeTab == 'maintenanceRequests'
                            ? 0
                            : activeTab == 'ongoingMaintenance'
                                ? 1
                                : 2,
                        // children: [
                        //   MaintenanceRequests(userId: userId),
                        //   StudentOngoingMaintenance(userId: userId),
                        //   StudentNotifications(userId: userId),
                        // ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTab(String title, String tab) {
    return InkWell(
      onTap: () => setActiveTab(tab),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: activeTab == tab ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: activeTab == tab ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
