import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataService{
  SharedPreferences _prefs;
  RxSharedPreferences _rxPrefs;

  Future _init() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _initRxPrefs() {
    if (_rxPrefs == null) _rxPrefs = RxSharedPreferences.getInstance();
  }

  Future setStringList(String key, List<String> value) async {
    await _init();
    return _prefs.setStringList(key, value);
  }

  Future<List<String>> getStringList(String key)async{
    await _init();
    List<String>result = _prefs.getStringList(key);
    return result;
  }

  Future setPref(String key, String value) async {
    await _init();
    print("Preference $key: $value");
    return _prefs.setString(key, value);
  }

  Future<String> getPref(String key) async {
    await _init();
    return _prefs.getString(key) ?? null;
  }
}