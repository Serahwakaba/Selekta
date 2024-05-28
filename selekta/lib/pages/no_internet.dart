import 'package:flutter/material.dart';

import 'MyHomePage.dart';

class Internet extends StatefulWidget {
  const Internet({super.key});

  @override
  State<Internet> createState() => _InternetState();
}

class _InternetState extends State<Internet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("OOPS!",style: TextStyle(fontSize: 24,color: Colors.red,fontWeight: FontWeight.bold),),

            Text("No Internet Connection",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
            Text("Your Internet Connection is down. please fix it to continue using Selekta.",style: TextStyle(fontSize: 16,color: Colors.black),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow, // Background color of the button
                  onPrimary: Colors.black, // Text color of the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          ],
        ),),
      ),
    );
  }
}
