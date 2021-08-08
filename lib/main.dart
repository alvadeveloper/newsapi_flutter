import 'package:flutter/material.dart';
import 'package:newsapi/screens/sportScreen.dart';

import 'screens/sportScreen.dart';
import 'screens/businessScreen.dart';
import 'screens/entertainmentScreen.dart';
import 'screens/technologyScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final pages = [
    SportScreen(),
    BusinessScreen(),
    entertainmentsScreen(),
    technologyScreen()
  ];
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('NEWS API'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.sports_soccer_outlined,
              ),
              label: 'Sports'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.business_outlined,
              ),
              label: 'Business'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.sports_esports_outlined,
              ),
              label: 'Entertainment'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.devices_outlined,
            ),
            label: 'Technology',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemClick,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.blueAccent),
        unselectedLabelStyle: TextStyle(color: Colors.black),
      ),
    ));
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
