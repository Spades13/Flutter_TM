import 'package:shared_preferences/shared_preferences.dart';

//uses preferences to loacally store data on which theme to use

class UserSimplePreferences{

  static late SharedPreferences _preferences;


  static Future init() async =>
        _preferences = await SharedPreferences.getInstance();



  static const _keyValue = 'value';

    


    static Future setValue(bool value) async =>
      await _preferences.setBool(_keyValue, value);
    
    static  getValue() => _preferences.getBool(_keyValue);
}