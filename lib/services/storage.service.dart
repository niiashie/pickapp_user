import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StorageService{
  SharedPreferences _prefs;
  RxSharedPreferences _rxPrefs;

  Future _init() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _initRxPrefs() {
    if (_rxPrefs == null) _rxPrefs = RxSharedPreferences.getInstance();
  }

  Stream<dynamic> getRxStreamPref<T>(String key, T type) {
    _initRxPrefs();
    if (type is String) {
      return _rxPrefs.getStringStream(key) ?? null;
    } else if (type is int) {
      return _rxPrefs.getIntStream(key) ?? null;
    } else {
      return null;
    }
  }

  dynamic getRxPref<T>(String key, T type) {
    _initRxPrefs();
    if (type is String) {
      return _rxPrefs.getString(key) ?? null;
    } else if (type is int) {
      return _rxPrefs.getInt(key) ?? null;
    }  else if (type is List<String>) {
      return _rxPrefs.getStringList(key) ?? [];
    } else {
      return null;
    }
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

  void dispose() {
    _rxPrefs.dispose();
  }

}