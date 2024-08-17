import 'package:flutter/material.dart';
import 'shop.dart';
import 'community.dart';
import 'home.dart';
import 'chat.dart';
import 'ai.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2; // Default to Home tab

  static final List<Widget> _widgetOptions = <Widget>[
    ShopPage(),
    CommunityPage(),
    HomePage(),
    GamePage(),
    AIChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(150, 42, 3, 202),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            label: 'AI',
          ),
        ],
      ),
    );
  }
}
