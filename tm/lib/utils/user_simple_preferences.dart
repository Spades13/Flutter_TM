//this programm sets the user preferences for the selected theme(light or dark mode) and store that locally on the devices
import 'package:shared_preferences/shared_preferences.dart';

//uses preferences to loacally store data on which theme to use

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  //final Map<String, Object> value = <String, Object>{'type': true};
  //bool mock = true;
  //UserSimplePreferences.setMockInitialValues(mock);

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const _keyValue = 'value';

  static Future setValue(bool value) async =>
      await _preferences.setBool(_keyValue, value);

  static getValue() => _preferences.getBool(_keyValue);
}
