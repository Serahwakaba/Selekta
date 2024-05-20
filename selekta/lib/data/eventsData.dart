
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/artist_details_model.dart';
import '../models/events_modell.dart';
import 'package:http/http.dart' as http;

import '../models/requests.dart';
import '../utils/exceptions.dart';


Future<List<EventsModel>> getEvents(payload) async{
  const endpoint =  "https://api.selekta.cc/events/list";
  var url = Uri.parse(endpoint);
  var headers = {
    "Content-Type": "application/json"
  };
  var response = await http.post(url,headers: headers,body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);
  if (kDebugMode) {
    print(decoded);
  }

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if (decoded.containsKey("data")){
    var jsonSkills = decoded['data'];

    return List.generate(jsonSkills.length, (index) => EventsModel.fromJson(jsonSkills[index]));
  }else{
    return [];
  }

}


Future<Map<String, dynamic>> createEvents(Map<String,dynamic> payload) async {
  const endpoint =  "https://api.selekta.cc/events/create";
  var url = Uri.parse(endpoint);

  var headers = {
    'Authorization': 'e5c83b13-9ca7-42cb-beef-8db95e1251d1',
  };

  var response = await http.post(url,headers: headers, body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);
  if (kDebugMode) {
    print(decoded);
  }
  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }

  return decoded;
}

Future<List<ArtistDetailsModel>> getArtistDetails(payload) async{

  const endpoint = "https://api.selekta.cc/artists/list";
  var url = Uri.parse(endpoint);

  var response = await http.post(url,body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if (decoded.containsKey("data")){
    var jsonSkills = decoded['data'];

    return List.generate(jsonSkills.length, (index) => ArtistDetailsModel.fromJson(jsonSkills[index]));
  }else{
    return [];
  }

}

Future<List<Requests>> getSongRequests(String query) async{
  final endpoint =  "https://deezerdevs-deezer.p.rapidapi.com/search?q=$query";
  var url = Uri.parse(endpoint);
  var headers = {
  "x-rapidapi-key": "ca1a2218b9mshb23d46857c7a8b7p1b0855jsn03b50861d10f",
  "x-rapidapi-host": "deezerdevs-deezer.p.rapidapi.com",
  };
  var response = await http.get(url,headers: headers);
  var decoded = jsonDecode(response.body);

   print('this is my search music api$decoded');

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if (decoded.containsKey("data")){
    var jsonSkills = decoded['data'];

    return List.generate(jsonSkills.length, (index) => Requests.fromJson(jsonSkills[index]));
  }else{
    return [];
  }

}