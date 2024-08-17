import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Импортируйте url_launcher

void main() {
  runApp(QuickStarterApp());
}

class QuickStarterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Starter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _QuickStarterHomeState createState() => _QuickStarterHomeState();
}

class _QuickStarterHomeState extends State<HomePage> {
  String fullName = 'Elisabetta Milesi';
  String username = 'Elisabetta_Milzi88';

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255), // Фиолетовый с прозрачностью
              Color.fromARGB(255, 205, 177, 255), // Светло-фиолетовый
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfileHeader(
                fullName: fullName,
                username: username,
              ),
            ),

            // Main Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'QUICK STARTER',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'So profitable. So reliable. Fully supportive.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.ac_unit, // Asterisk-like icon
                      size: 80,
                      color: Color(0xFF6A5ACD),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _launchURL('https://quickstarter.kz/');
                        },
                        child: Text(
                          'Learn more >',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Buy logic
                        },
                        child: Text(
                          'News >',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Event Reminder
            Container(
              padding: EdgeInsets.all(15),
              color: Color(0xFF000080), // Dark Blue color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Event Reminder',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'SAT Webinar “How to get 1590 on SAT?”',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
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

class ProfileHeader extends StatelessWidget {
  final String fullName;
  final String username;

  ProfileHeader({required this.fullName, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40.0,
            child: Icon(Icons.person, size: 40, color: Colors.black),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '@$username',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
