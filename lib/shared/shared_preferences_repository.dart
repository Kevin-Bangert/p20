import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  // Hilfsmethode, um SharedPreferences-Instanz zu holen
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    final prefs = await _getPrefs();
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }

  Future<void> deleteData(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }

  @override
  Future<void> addItem(String item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(int index) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<void> editItem(int index, String newItem) {
    // TODO: implement editItem
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getItems() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  // TODO: implement itemCount
  Future<int> get itemCount => throw UnimplementedError();
}
