import 'package:shared_preferences/shared_preferences.dart';

const ROOT_URL = "https://selekta.mocyiltd.com/api";


setPrefsString(String key,String value)async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setString(key, value);
}


setPrefsInt(String key,int value)async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setInt(key, value);
}


setPrefsBool(String key,bool value)async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setBool(key, value);
}


Future<String> getPrefsString(String key) async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(key)??"";
}


Future<int> getPrefsInt(String key) async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  return prefs.getInt(key)??0;
}


Future<bool> getPrefsBool(String key) async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  return prefs.getBool(key)??false;
}
