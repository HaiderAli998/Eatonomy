import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  static Future<String?> getProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('ProfilePic');
  }


  static Future<String?> getProfileName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Name');
  }

  static Future<String?> getProfileNameGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('GoogleName');
  }
  static Future<String?> getProfileEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Email');
  }


}
