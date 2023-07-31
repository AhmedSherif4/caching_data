import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String _keyData = 'myData';
  static const String _keyExpiration = 'expirationTime';

  Future<bool> saveDataWithExpiration(String data, Duration expirationDuration) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime expirationTime = DateTime.now().add(expirationDuration);
      await prefs.setString(_keyData, data);
      await prefs.setString(_keyExpiration, expirationTime.toIso8601String());
      print('Data saved to SharedPreferences.');
      return true;
    } catch (e) {
      print('Error saving data to SharedPreferences: $e');
      return false;
    }
  }

  Future<String?> getDataIfNotExpired() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(_keyData);
      String? expirationTimeStr = prefs.getString(_keyExpiration);
      if (data == null || expirationTimeStr == null) {
        print('No data or expiration time found in SharedPreferences.');
        return null; // No data or expiration time found.
      }

      DateTime expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isAfter(DateTime.now())) {
        print('Data has not expired.');
        // The data has not expired.
        return data;
      } else {
        // Data has expired. Remove it from SharedPreferences.
        await prefs.remove(_keyData);
        await prefs.remove(_keyExpiration);
        print('Data has expired. Removed from SharedPreferences.');
        return null;
      }
    } catch (e) {
      print('Error retrieving data from SharedPreferences: $e');
      return null;
    }
  }

  Future<void> clearData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyData);
      await prefs.remove(_keyExpiration);
      print('Data cleared from SharedPreferences.');
    } catch (e) {
      print('Error clearing data from SharedPreferences: $e');
    }
  }



}
