import 'package:shared_preferences/shared_preferences.dart';
import 'package:techtest/src/domain/datasources/local/local_storage.dart';

class SharedPreferenceStorage implements LocalStorage {
  @override
  Future<void> setBool({required String index, required bool value}) async {
    var _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(index, value);
  }

  @override
  Future<void> setString({required String index, required String value}) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(index, value);
  }

  @override
  Future<bool?> getBool({required String index}) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(index);
  }

  @override
  Future<String?> getString({required String index}) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(index);
  }

  @override
  Future<void> remove({required index}) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(index);
  }
}
