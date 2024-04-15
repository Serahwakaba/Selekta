import 'package:flutter/material.dart';
import 'package:selekta/pages/profile.dart';
import 'package:selekta/pages/requests_page.dart';

import 'MyHomePage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    RequestaPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.purple, Colors.pink],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),

      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
        canvasColor:  Color(0xFFFDE3163),
            textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child:  BottomNavigationBar(
          unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats_outlined),
            label: 'Requests Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      ));

  }
}




class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('More Page'),
    );
  }
}
