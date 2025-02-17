import 'dart:math';
import 'package:flutter/material.dart';

class Mainhomepage extends StatefulWidget {
  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<Mainhomepage> {
     int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'HOME PAGE',
      style: optionStyle,
    ),
    Text(
      'COURSE PAGE',
      style: optionStyle,
    ),
    Text(
      'CONTACT GFG',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
       child:   Text("hey")
    ),bottomNavigationBar:  BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: ('Settings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ('profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ));
  }
}
