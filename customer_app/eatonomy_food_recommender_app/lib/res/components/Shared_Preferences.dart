import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  static Future<String?> getProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('ProfileUrl');
  }


  static Future<String?> getProfileName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Name');
  }

  static Future<String?> getProfileNameGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('GoogleName');
  }
}
