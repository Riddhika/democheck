import 'package:shared_preferences/shared_preferences.dart';


//Todo shared pref
// ignore: constant_identifier_names
const KEY_INTRO ="key_intro";
const KEY_LOGIN="key_login";
const KEY_USERNAME="Username";
const KEY_PHOTOURL="photoUrl";
const KEY_ID="id";
const KEY_FNAME="firstname";
const KEY_LNAME="lastname";
const KEY_EMAIL="email";
const KEY_PASSWORD="password";
const KEY_EMAIL_LOGIN="emaillogin";
const KEY_SOCIAL_LOGIN="sociallogin";
const KEY_PUSH_NOTI_ALLOW="pushnotificationallow";
const KEY_AUDIO_ALLOW="audioallowpush";
const KEY_CRASH_ALLOW="crashallow";
const KEY_IMPRINT="keyimprint";
const KEY_TERMANDUSE="keytermanduse";


setPrefStringValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

getPrefStringValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "";
}

setPrefIntValue(String key,value) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setInt(key,value);
}

getPrefIntValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

setPrefBoolValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

getPrefBoolValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

setPrefDoubleValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}


getPrefDoubleValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(key);
}
removePrefValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}