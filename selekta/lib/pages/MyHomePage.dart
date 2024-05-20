import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data/eventsData.dart';
import '../models/events_modell.dart';
import '../utils/exceptions.dart';
import 'Signup.dart';
import 'event_details.dart';
import 'landing_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<EventsModel> eventsModel=[];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController songRateController = TextEditingController();



  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedStartDate != null) {
      setState(() {
        _startDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedEndDate != null) {
      setState(() {
        _endDate = pickedEndDate;
      });
    }
  }

  loadEvents(){
    var payload = { };
  getEvents(payload).then((value){
      eventsModel  = value;
      setState(() {
        eventsModel  = value;
      });
    }).catchError((onError){
      if(onError is UnableToProcess){
        EasyLoading.showError("An error occurred:${onError.reason} ",duration: Duration(seconds: 20),dismissOnTap: true);
      }else{
        EasyLoading.showError("Error loading events data ",duration: Duration(seconds: 20),dismissOnTap: true);

      }

    });
  }

  @override
  void initState() {
    loadEvents();
   // getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color:  Color(0xFFF150B29)

          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Container(
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                          child: Image.asset(
                            'assets/logo.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    SizedBox(width: 120,),
                    Spacer(),

                    Container(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        ),
                        child: Text("Sign Up",style: TextStyle(fontSize: 12),),
                      ),
                    ),
                      SizedBox(width: 20,)
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [Colors.pink, Colors.purple,Colors.orange],
                      // ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                  padding: EdgeInsets.only(left: 20,right: 20),

                  child: Row(
                    children: [
                      Text("AMAZING EVENTS \n IN  YOUR AREA",style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w800),textAlign: TextAlign.left,),

                    ],
                  ),),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search DJ',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
              Container(
                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 0),
                  child: Row(
                    children: [
                      Text("Trending Now",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),),
                     Spacer(),
                      Container(
                        width: 120,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement your login functionality here
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                            title: CreateEvent(),

                            );


                          });

                            },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow, // Background color of the button
                            onPrimary: Colors.black, // Text color of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Create Event',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),

                    ],
                  )),
             SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for(var event in eventsModel)eventsWidget(event)
                    ],
                  ),
                ),

                SizedBox(height: 30,),
                Container(
                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 0),
                    child: Row(
                      children: [
                        Text("Events",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: Colors.white),),

                      ],
                    )),
                SizedBox(height: 20,),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Column(
                //     children: [
                //       for(var event in eventsModel)eventsWidget(event)
                //     ],
                //   ),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      // Split events into pairs
                      for (int i = 0; i < eventsModel.length; i += 2)
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Container(
                                  child: eventsWidget(eventsModel[i])),
                              if (i + 1 < eventsModel.length)
                                Container(

                                    child: eventsWidget(eventsModel[i + 1])),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      );
  }

  Widget eventsWidget(EventsModel event){
    return GestureDetector(
      onTap: ()
      => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetails())),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              height: 160,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
        //       child: Image.network(
        //           event.imageUrl,
        //           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        //             if (loadingProgress == null)
        //               return child;
        //             return CircularProgressIndicator(
        //               value: loadingProgress.expectedTotalBytes != null
        //                   ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
        //                   : null,
        //             );
        //           },
        //         ),
        //       ),
        // ),


              child:ClipRRect(
                borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                child: Image.asset(
                  "assets/d.jpg",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(event.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            Text(
              event.description!.length > 30
                  ? '${event.description?.substring(0, 30)}...'
                  : event.description.toString(),
              style:TextStyle(color: Colors.white,fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // Adjust maxLines according to your need
            ),

            SizedBox(height: 10),
            Row(children: [
              Icon(Icons.favorite,color: Colors.yellow),
              SizedBox(width: 20,),
              Icon(Icons.recommend,color: Colors.yellow),
              SizedBox(width:20,),
              Icon(Icons.message,color: Colors.yellow),
            ],)
          ],),),
    );

  }
  Widget  DJListItem(EventsModel event){
    return GestureDetector(
      onTap: ()
      => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetails())),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              height: 160,
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
              //       child: Image.network(
              //           event.imageUrl,
              //           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              //             if (loadingProgress == null)
              //               return child;
              //             return CircularProgressIndicator(
              //               value: loadingProgress.expectedTotalBytes != null
              //                   ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              //                   : null,
              //             );
              //           },
              //         ),
              //       ),
              // ),


              child:ClipRRect(
                borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                child: Image.asset(
                  "assets/d.jpg",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(event.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            SizedBox(height: 10,),
            Text(
              event.description!.length > 30
                  ? '${event.description?.substring(0, 30)}...'
                  : event.description.toString(),
              style:TextStyle(color: Colors.white,fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // Adjust maxLines according to your need
            ),

            SizedBox(height: 10),
            Row(children: [
              Icon(Icons.favorite,color: Colors.red),
              SizedBox(width: 20,),
              Icon(Icons.recommend,color: Colors.orange),
              SizedBox(width:20,),
              Icon(Icons.message,color: Colors.green),
            ],)
          ],),),
    );

  }

  Widget CreateEvent(){
    return Container(
      child: Column(
        children: [
        Container(

            child: Text("Create Event",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),textAlign: TextAlign.start,)),

 SizedBox(height: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(child: Text("Event Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
          SizedBox(height: 10,),
          Container(
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Summer Vacation',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 20,right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
          ),
            SizedBox(height: 20,),
            Container(child: Text("Description",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
            SizedBox(height: 10,),

            Container(

              child: TextField(
                controller:descriptionController,
                decoration: InputDecoration(
                  hintText: 'enter description',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.only(left: 20,right: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(child: Text("Location",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
          SizedBox(height: 10,),

          Container(

            child: TextField(
              controller:venueController,
              decoration: InputDecoration(
                hintText: 'Sarit Centre',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 20,right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
          ),
            SizedBox(height: 20,),

            Container(child: Text("Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
    Padding(
    padding: EdgeInsets.all(6.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(children: [
        ElevatedButton(
          onPressed: () => _selectStartDate(context),
          child: Text('Start Date'),
        ),
        Text(
          _startDate != null
              ? 'Start Date: ${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
              : 'Select Start Date',style: TextStyle(fontSize: 12),
        ),
      ]),
SizedBox(width: 20,),
Column(children: [
  ElevatedButton(
    onPressed: () => _selectEndDate(context),
    child: Text('End Date'),
  ),
  Text(
    _endDate != null
        ? 'End Date ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
        : 'Select End Date',style: TextStyle(fontSize: 12),
  ),
],)

    ],
    ),
    ),

            SizedBox(height: 20,),
            Container(child: Text("Charges Per Request",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
            SizedBox(height: 10,),
            Container(
              child: TextField(
                controller: songRateController,
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.only(left: 20,right: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                ),
              ),
            ),
        ],),


          SizedBox(height: 30,),
        Container(
          width: double.infinity,

          child: ElevatedButton(
            onPressed: () {
              // Implement your login functionality here
              var payload = {
                "Title":  titleController.text,
                "Description": descriptionController.text,
                "Venue": venueController.text,
                "ImageUrl": "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE",
                "EventTime": _startDate.toString(),
                "SongRate": int.parse(songRateController.text)
                // "Title": titleController.text,
                // "Description": descriptionController.text,
                // "Venue": venueController.text,
                // "ImageUrl": "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE",
                // "EventTime": _startDate,
                // "SongRate": int.parse(songRateController.text),
              };
              if (kDebugMode) {
                print(payload);
              }
              createEvents(payload).then((value){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }).catchError((onError){
                if (onError is UnableToProcess){
                  EasyLoading.showError(onError.reason,dismissOnTap: true,duration: Duration(seconds: 20));
                }else{
                  EasyLoading.showError("An error occurred, please try again",dismissOnTap: true,duration: Duration(seconds: 20));
                }
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.pinkAccent, // Background color of the button
              onPrimary: Colors.white, // Text color of the button
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: Text(
              'Create Event',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],),
    );
  }
}
