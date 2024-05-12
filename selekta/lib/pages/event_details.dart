import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../data/eventsData.dart';
import '../models/artist_details_model.dart';
import '../models/events_modell.dart';
import '../models/requests.dart';
import '../utils/app_utils.dart';
import '../utils/exceptions.dart';
import 'landing_page.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<ArtistDetailsModel> artistDetails=[];
  final characterCounts = <String, int>{};
  String access_token = "";
  final TextEditingController songTitleController = TextEditingController();
  final TextEditingController songArtistController = TextEditingController();
  final TextEditingController songAmountController = TextEditingController();
   bool isLoading = false;
  List<Requests> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  bool isChecked = false;

  // fetchRequests(){
  //   getSongRequests(_searchController.text).then((value){
  //     _searchResults  = value;
  //     setState(() {
  //       _searchResults  = value;
  //     });
  //   }).catchError((onError){
  //     if(onError is UnableToProcess){
  //       EasyLoading.showError("An error occurred:${onError.reason} ",duration: Duration(seconds: 20),dismissOnTap: true);
  //     }else{
  //       EasyLoading.showError("Error loading music data ",duration: Duration(seconds: 20),dismissOnTap: true);
  //     }
  //   });
  // }

  fetchRequests() {
    setState(() {
      isLoading = true;
    });
    getSongRequests(_searchController.text).then((value) {
        setState(() {
          isLoading = false;
          _searchResults  = value;
        });
      }



    );
  }


  bool isBalancedString(String inputString) {
    // Count occurrences of each character.
    final characterCounts = <String, int>{};
    for (var character in inputString.runes.map((codePoint) => String.fromCharCode(codePoint))) {
      characterCounts[character] = (characterCounts[character] ?? 0) + 1;
    }

    // Get the set of counts.
    final countSet = characterCounts.values.toSet();

    // Check if there is only one distinct count.
    return countSet.length == 1;
  }

  bool balanced(String inputString) {

    final numberCount = <String,int>{};
    for(var character in inputString.runes.map((code)  => String.fromCharCode(code))){
      numberCount[character] =
          (numberCount[character] ?? 0)+ 1;
    }

    //get the counts
    final count = numberCount.values.toSet();

    //get the size if its 1
    return count.length == 1;

    //return true;
  }

  loadEventsDetails(){
    getPrefsString("access_token").then((value) async {
      if (value.isEmpty) {
        return;
      }

      var payload = {
        "user_token": access_token,
        "artist_id": 2
      };

      if (kDebugMode) {
        print(payload);
      }

      getArtistDetails(payload).then((value) {
        artistDetails = value;
        setState(() {
          artistDetails = value;
        });
      }).catchError((onError) {
        if (onError is UnableToProcess) {
          EasyLoading.showError("An error occurred:${onError.reason} ",
              duration: Duration(seconds: 20), dismissOnTap: true);
        } else {
          EasyLoading.showError(
              "Error loading artist data ", duration: Duration(seconds: 20),
              dismissOnTap: true);
        }
      }
      );
    }); }


  @override
  void initState() {
    loadEventsDetails();
    fetchRequests();
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFFF150B29),

leading:  IconButton(onPressed: (){
  Navigator.pop(context);
}
    , icon: Icon(Icons.chevron_left,color: Colors.grey,)),
      title:     Container(

        child: Row(
          children: [


            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
              child: Image.asset(
                'assets/logo.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            for(var details in artistDetails)Details(details)
          ],
        )
    ));
  }
 // for(var details in artistDetails)Details(details)

  Widget Details(ArtistDetailsModel details){
    return  Container(
      decoration: BoxDecoration(
          color:  Color(0xFFF150B29)

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30,right: 10,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Text(details.stageName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                  Spacer(),
                    Column(
                      children: [
                        Text("KSH 50/-",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                        Text("PER MUSIC",style: TextStyle(fontSize: 10,color: Colors.white),),
                      ],
                    ),
                  ],
                ),
                Text(details.description,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 160,
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                    child: Image.asset(
                      "assets/d.jpg",
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                    child: Text("Search to request",style: TextStyle(fontSize:18,fontWeight: FontWeight.w600,color: Colors.white),)),
                SizedBox(height: 20,),
                Container(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      fetchRequests();
                    },
                    style: TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      hintText: 'Search Music',
                      hintStyle: TextStyle(color: Colors.white),

                      prefixIcon: IconButton(
                          onPressed: () {
                            fetchRequests()  ;                        },
                          icon: Icon(Icons.search)),
                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20,),
                DJListItem(searchResults: _searchResults),

              ],
            ),),
        ],),
    );
  }
  Widget  DJListItem({required List<Requests> searchResults}){
    return  Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500,
                margin: EdgeInsets.only(bottom: 0, top: 0),
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final song = _searchResults[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/intro.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text('Failed to load image'),
                                );
                              },
                            ),
                          ),
                        ),
                        title: Text(
                          song.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.artistName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        trailing: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 180, // Adjust the position as needed
          right: 10, // Adjust the position as needed
          child: Container(
            width: 100,
            height: 50,
            child: FloatingActionButton(
              onPressed: () {
                // Handle button press
              },
              child: Text("REQUEST"),
            ),
          ),
        ),
      ],
    );


  }
  Widget RequestMusic(){
    return Container(
      child: Column(
        children: [
          Container(
              child: Text("Request Music",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),textAlign: TextAlign.start,)),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Text("Song Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
              SizedBox(height: 10,),
              Container(
                child: TextField(
                  controller: songTitleController,
                  decoration: InputDecoration(
                    hintText: 'time of my life',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 20,right: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(child: Text("Artist",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
              SizedBox(height: 10,),

              Container(

                child: TextField(
                  controller:songArtistController,
                  decoration: InputDecoration(
                    hintText: 'Nyashinski',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 20,right: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Container(child: Text("Charges Per Request",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),),
              SizedBox(height: 10,),
              Container(
                child: TextField(
                  controller: songAmountController,
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
                // // Implement your login functionality here
                // var payload = {
                //   "Title":  titleController.text,
                //   "Description": descriptionController.text,
                //   "Venue": venueController.text,
                //   "ImageUrl": "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE",
                //   "EventTime": _startDate.toString(),
                //   "SongRate": int.parse(songRateController.text)
                //   // "Title": titleController.text,
                //   // "Description": descriptionController.text,
                //   // "Venue": venueController.text,
                //   // "ImageUrl": "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE",
                //   // "EventTime": _startDate,
                //   // "SongRate": int.parse(songRateController.text),
                // };
                // if (kDebugMode) {
                //   print(payload);
                // }
                // createEvents(payload).then((value){
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => MyHomePage()),
                //   );
                // }).catchError((onError){
                //   if (onError is UnableToProcess){
                //     EasyLoading.showError(onError.reason,dismissOnTap: true,duration: Duration(seconds: 20));
                //   }else{
                //     EasyLoading.showError("An error occurred, please try again",dismissOnTap: true,duration: Duration(seconds: 20));
                //   }
                // });
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
                'Proceed',
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

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, size.height * 0.8, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
