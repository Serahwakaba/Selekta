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
import '../utils/shimmer_look.dart';
import 'landing_page.dart';

class EventDetails extends StatefulWidget {
   final int eventId;

    EventDetails(
   {required this.eventId}
        );

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<ArtistDetailsModel> artistDetails = [];
  late Future<List<ArtistDetailsModel>> eventsDetailsFuture;

  final characterCounts = <String, int>{};
  String access_token = "";
  final TextEditingController songTitleController = TextEditingController();
  final TextEditingController songArtistController = TextEditingController();
  final TextEditingController songAmountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  List<Requests> _searchResults = [];
  List<Requests> _selectedSongs = [];
  TextEditingController _searchController = TextEditingController();
  int? isChecked;

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
        _searchResults = value;
      });
    }


    );
  }
  bool isBalancedString(String inputString) {
    // Count occurrences of each character.
    final characterCounts = <String, int>{};
    for (var character in inputString.runes.map((codePoint) =>
        String.fromCharCode(codePoint))) {
      characterCounts[character] = (characterCounts[character] ?? 0) + 1;
    }

    // Get the set of counts.
    final countSet = characterCounts.values.toSet();

    // Check if there is only one distinct count.
    return countSet.length == 1;
  }
  bool balanced(String inputString) {
    final numberCount = <String, int>{};
    for (var character in inputString.runes.map((code) =>
        String.fromCharCode(code))) {
      numberCount[character] =
          (numberCount[character] ?? 0) + 1;
    }

    //get the counts
    final count = numberCount.values.toSet();

    //get the size if its 1
    return count.length == 1;

    //return true;
  }
  Future<List<ArtistDetailsModel>> loadEventsDetails(int artistId) async {
    try {
      String accessToken = await getPrefsString("access_token");

      /*if (accessToken.isEmpty) {
      print("value is empty ++++++++");
      return [];
    }*/

      var payload = {
        // "user_token": access_token,
        "artist_id": artistId
      };

      if (kDebugMode) {
        print('this is my details payload artist id $artistId');
        print(payload);
      }

      List<ArtistDetailsModel> artistDetails = await getArtistDetails(payload);

      setState(() {
        this.artistDetails = artistDetails;
      });

      return artistDetails;
    } catch (onError) {
      if (onError is UnableToProcess) {
        EasyLoading.showError("An error occurred: ${onError.reason}",
            duration: Duration(seconds: 20), dismissOnTap: true);
      } else {
        EasyLoading.showError(
            "Error loading artist data",
            duration: Duration(seconds: 20),
            dismissOnTap: true
        );
      }
      return [];
    }
  }




  @override
  void initState() {
    eventsDetailsFuture= loadEventsDetails(widget.eventId);
    fetchRequests();
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF150B29),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }
              , icon: Icon(Icons.chevron_left, color: Colors.grey,)),
          title: Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the radius value as needed
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
        body: FutureBuilder<List<ArtistDetailsModel>>(
          future: eventsDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  OdiShimmerComponent(height: 500);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No artist details found'));
            } else {
              var artistDetails = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var details in artistDetails) Details(details),
                  ],
                ),
              );
            }
          },
        ),
    );
        // SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         //Text("james Theme.of(context)",)
        //         for(var details in artistDetails)Details(details)
        //       ],
        //     )
        // ));
  }

  // for(var details in artistDetails)Details(details)

  Widget Details(ArtistDetailsModel details) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF150B29)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(details.stageName, style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    Spacer(),
                    Column(
                      children: [
                        Text("KSH 50/-", style: TextStyle(fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),),
                        Text("PER MUSIC",
                          style: TextStyle(fontSize: 10, color: Colors.white),),
                      ],
                    ),
                  ],
                ),
                Text(details.description, style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // Adjust the radius value as needed
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
                    child: Text("Search to request", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),)),
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
                            fetchRequests();
                          },
                          icon: Icon(Icons.search)),
                      contentPadding: EdgeInsets.only(left: 20, right: 20),
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

  Widget DJListItem({required List<Requests> searchResults}) {
    return Stack(
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
                      child:
                      ListTile(
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
                          // value: isChecked == index
                          value: _selectedSongs.contains(song),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value ?? false) {
                                _selectedSongs.add(song);
                                // isChecked = index;
                              } else {
                                _selectedSongs.remove(song);
                                //isChecked = null;
                              }
                              // songAmountController.text =
                              //     (_selectedSongs.length * 50).toString();
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
              onPressed:  _selectedSongs.isEmpty
                  ? null
                  : () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: RequestMusic(
                            selectedSongs: _selectedSongs,
                            onProceed: () => _handleProceed(context)),

                      );
                    });
              },
              child: Text("REQUEST"),
            ),
          ),
        ),
      ],
    );
  }

  Widget RequestMusic({required List<
      Requests> selectedSongs, required void Function() onProceed}) {

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                child:
                Text("Confirm Request to proceed",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  textAlign: TextAlign.start,)
            ),
            SizedBox(height: 20,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Selected Songs:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  textAlign: TextAlign.start,),

                Container(
                  width: 400,
                  height: 150, // Adjusted height to make it scrollable
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: selectedSongs.length,
                      itemBuilder: (context, index) {
                        final song = selectedSongs[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10), // Adjusted padding
                          title: Text(
                            '${index + 1}. ${song.title} - ${song.artistName}',
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Text("Enter PhoneNumber", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),),),
                SizedBox(height: 10,),
                Container(
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixText: '+254 | ',
                      prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
                      hintText: '703*******',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 20, right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Text("Charges Per Request", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),),),
                SizedBox(height: 10,),
                Container(
                  child: TextField(
                    controller: songAmountController,
                    //readOnly: true,
                    decoration: InputDecoration(
                      //hintText: 'Enter amount',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 20, right: 20),
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
                  onProceed();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  // Background color of the button
                  onPrimary: Colors.black,
                  // Text color of the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  // Button padding
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
      ),
    );
  }

  Widget Confirm(){
    return Container(
      child: Column(children: [
        Text("Confirm Requst"),
        SizedBox(height: 20,),
        Container(
          width: double.infinity,

          child: ElevatedButton(
            onPressed: () {

             },
            style: ElevatedButton.styleFrom(
              primary: Colors.yellow,
              // Background color of the button
              onPrimary: Colors.black,
              // Text color of the button
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: Text(
              'Confirm',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),

      ],),
    );
  }

  Future<void> _sendPaymentRequest() async {
    final endpoint = "https://pay.mocyiltd.com/mpesa/express/create";
    var url = Uri.parse(endpoint);
    Map<String, dynamic> paymentData = {

      "ConsumerKey": "8cYAoiXNdFA2wyUbnZmA0Guf7uvQRIoGEezGA2U5RCeCeRVC",
      "ConsumerSecret": "gKMslMZTurIdoxWADo2O9Vm5OA7rnw1gkj8A3ME1ys7U2gSWNuULCHCswAQ3iDEF",
      "Passkey": "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      "BusinessShortCode": "174379",
      "TransactionType": "CustomerPayBillOnline",
      "Amount": songAmountController.text,
      "PhoneNumber": '254${phoneController.text}',
      "TransactionDesc": "Payment for Goods",
      "CallBackURL": "https://api.selekta.cc/transactions/mpesa/stk/callback"
    };

    try {
      EasyLoading.show(status: 'Loading...');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(paymentData),
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Payment Initiated successfully!');
        await Future.delayed(Duration(seconds: 3));

         _confirmRequest();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'Failed to send payment request. Status code: ${response
                .statusCode}');
        print("Failed to send payment request. Status code: ${response
            .statusCode}");
        print("Failed to send payment request. Status code: ${response
            .statusCode}");
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'Error occurred while sending payment request: $error');
      print("Error occurred while sending payment request: $error");
    }
  }

  Future<void> _confirmRequest() async {
    final endpoint = "https://pay.mocyiltd.com/mpesa/express/create";
    var url = Uri.parse(endpoint);
    List<String> selectedSongsTitles = _selectedSongs.map((song) => '${song.title} - ${song.artistName}').toList();
    String requestMessage = selectedSongsTitles.join(', ');
    Map<String, dynamic> paymentData = {
        "EventID": 14,
        "ArtistID": 3,
        "RequestMessage": requestMessage,
        "Status": -2,
        "TransactionID": 2,
        "Amount":  songAmountController.text,
       "Mobile": '254${phoneController.text}'

    };
    if (kDebugMode) {
      print(paymentData);
    }
    try {
      EasyLoading.show(status: 'Wait for confirmation...');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': '63a8960b-bbed-4f80-8414-143378a2bd13',
        },
        body: jsonEncode(paymentData),
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Request confirmed successfully!');
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'Confirmation Failed ${response.statusCode}');

        print("Confirmation Failed${response
            .statusCode}");

        print("Confirmation Failed ${response
            .statusCode}");
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'Error occurred while sending  request: $error');
      print("Error occurred while sending  request: $error");
    }
  }

  void _handleProceed(BuildContext dialogContext) async {
    _sendPaymentRequest();
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(dialogContext).pop();
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
