
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/artist_details_model.dart';
import '../models/events_modell.dart';
import 'package:http/http.dart' as http;

import '../utils/exceptions.dart';


Future<List<EventsModel>> getEvents(payload) async{
  const endpoint =  "https://selekta.mocyiltd.com/api/events/list";
  var url = Uri.parse(endpoint);
  var headers = {
    "Content-Type": "application/json"
  };
  var response = await http.post(url,headers: headers,body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);

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
  const endpoint =  "https://selekta.mocyiltd.com/api/events/create";
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

  const endpoint = "https://selekta.mocyiltd.com/api/artists/list";
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