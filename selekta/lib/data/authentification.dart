import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../utils/app_utils.dart';
import '../utils/exceptions.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> signUp(Map<String,dynamic> payload) async {
  const endpoint =  "https://api.selekta.cc/auth/signup";
  var url = Uri.parse(endpoint);

  var headers = {
    'Accept': 'application/json',
    "Content-Type": "application/json"
  };
  print(payload);

  var response = await http.post(url,headers: headers, body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);
  print(decoded);

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if(decoded["status"]==0){
    throw UnableToProcess(reason: decoded["message"]);
  }
  return decoded;
}
Future<Map<String, dynamic>> login(Map<String,dynamic> payload) async {
  const endpoint =  "https://api.selekta.cc/auth/login";
  var url = Uri.parse(endpoint);

  var headers = {
    'Accept': 'application/json',
    "Content-Type": "application/json"
  };

  var response = await http.post(url,headers: headers, body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);
  if (kDebugMode) {
    print(decoded);
  }

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if(decoded["status"]==0){
    throw UnableToProcess(reason: decoded["message"]);
  }
  var token = decoded["access_token"];
  setPrefsString("access_token",token);
  log(token );

  return decoded;
}
Future<Map<String, dynamic>> resetPassword(Map<String,dynamic> payload) async {
  const endpoint =  "https://selekta.mocyiltd.com/api/auth/set/password";
  var url = Uri.parse(endpoint);

  var headers = {
    'Accept': 'application/json',
    "Content-Type": "application/json"
  };
  print(payload);

  var response = await http.post(url,headers: headers, body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);
  print(decoded);

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if(decoded["status"]==0){
    throw UnableToProcess(reason: decoded["message"]);
  }
  return decoded;
}
Future<Map<String, dynamic>> forgotPassword(Map<String,dynamic> payload) async {
  const endpoint =  "https://selekta.mocyiltd.com/api/auth/forgot/password";
  var url = Uri.parse(endpoint);

  var headers = {
    'Accept': 'application/json',
    "Content-Type": "application/json"
  };
  print(payload);

  var response = await http.post(url,headers: headers, body: jsonEncode(payload));
  var decoded = jsonDecode(response.body);
  print(decoded);

  if (response.statusCode < 200 || response.statusCode > 299) {
    throw UnableToProcess(reason: decoded.toString());
  }
  if(decoded["status"]==0){
    throw UnableToProcess(reason: decoded["message"]);
  }
  return decoded;
}