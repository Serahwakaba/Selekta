import 'package:flutter/material.dart';

import 'MyHomePage.dart';
import 'landing_page.dart';


class IntroPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreens(),
    );
  }
}

class WelcomeScreens extends StatefulWidget {
  @override
  State<WelcomeScreens> createState() => _WelcomeScreensState();
}

class _WelcomeScreensState extends State<WelcomeScreens> {
  int _currentIndex = 0;
  PageController _pageController = PageController(viewportFraction: 1);

  final List<String> welcomeMessages = [
    "A new interactive way of Requesting  Songs to your favorite DJs",
    "Show appreciation for the DJ with virtual tips.",
  ];


  final List<String> imagePaths = [
    "assets/intro.jpg",
    "assets/d.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            imagePaths[_currentIndex], // Use image based on index
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      welcomeMessages[0],
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    // Optional: Add buttons or other elements here
                  ],
                ),
              ),
              // Welcome screen 2 with button to navigate to Home Page
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      welcomeMessages[1],
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()),
                      ),
                      child: Text("Go to Home Page"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Experience",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Appreciate",
          ),
        ],
      ),
    );
  }
}
