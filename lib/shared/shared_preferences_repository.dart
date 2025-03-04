import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _itemsKey = 'checklist_items';

  // Hilfsmethode, um SharedPreferences-Instanz zu holen
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Hilfsmethode, um die Liste aus SharedPreferences zu laden
  Future<List<String>> _loadItems() async {
    final prefs = await _getPrefs();
    final String? itemsJson = prefs.getString(_itemsKey);
    if (itemsJson != null) {
      final List<dynamic> itemsList = json.decode(itemsJson);
      return itemsList.cast<String>();
    }
    return [];
  }

  // Hilfsmethode, um die Liste in SharedPreferences zu speichern
  Future<void> _saveItems(List<String> items) async {
    final prefs = await _getPrefs();
    final String itemsJson = json.encode(items);
    await prefs.setString(_itemsKey, itemsJson);
  }

  @override
  Future<void> addItem(String item) async {
    final items = await _loadItems();
    items.add(item);
    await _saveItems(items);
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await _loadItems();
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await _saveItems(items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final items = await _loadItems();
    if (index >= 0 && index < items.length) {
      items[index] = newItem;
      await _saveItems(items);
    }
  }

  @override
  Future<List<String>> getItems() async {
    return await _loadItems();
  }

  @override
  Future<int> get itemCount async {
    final items = await _loadItems();
    return items.length;
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
}
