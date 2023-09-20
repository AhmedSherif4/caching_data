import 'dart:developer' as devtools show log;

import 'package:hive/hive.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class BaseLocalDataSource {
  final List<int> _secureKey = Hive.generateSecureKey();
  static const String _boxExpiration = 'boxExpiration';
  static const String _boxData = 'boxData';

  void saveInLocalBox<T>({
    required String labelKey,
    required T data,
    required Duration expirationDuration,
    bool isSecured = false,
  }) async {
    try {
      'saveInLocalBox Opening expiration box'.log();
      final Box<String> expirationBox = await Hive.openBox<String>(
        _boxExpiration,
      );
      'saveInLocalBox Putting expiration time in box'.log();
      expirationBox.put(
        labelKey,
        DateTime.now().add(expirationDuration).toIso8601String(),
      );
      'saveInLocalBox Opening data box'.log();
      final Box<T> dataBox = await Hive.openBox<T>(
        _boxData,
        encryptionCipher: isSecured ? HiveAesCipher(_secureKey) : null,
      );
      'saveInLocalBox Putting data in box'.log();
      dataBox.put(labelKey, data);
    } catch (error) {
      'saveInLocalBox Error saving data in local box: $error'.log();
    } finally {
      'saveInLocalBox Closing all open boxes'.log();
      Hive.close();
    }
  }

  Future<T?> getFromLocalBox<T>({
    required String labelKey,
    bool isSecured = false,
  }) async {
      labelKey.log();
    // Try to open the expiration box and get the expiration time.
    try {
      'getFromLocalBox Opening expiration box'.log();
      final expirationBox = await Hive.openBox<String>(_boxExpiration);
      final expirationTimeFromBox = expirationBox.get(labelKey);

      // Open the data box and get the data.
      'getFromLocalBox Opening data box'.log();
      final dataBox = await Hive.openBox<T>(
        _boxData,
        encryptionCipher: isSecured ? HiveAesCipher(_secureKey) : null,
      );
      final data = dataBox.get(labelKey);


      'data == null'.log();
      '${data == null}'.log();
      'expirationTimeFromBox == null'.log();
      '${expirationTimeFromBox == null}'.log();
      // If the data or expiration time is null, return null.
      if (data == null || expirationTimeFromBox == null) {
        return null;
      }

      // Parse the expiration time and compare it to the current time.
      DateTime expirationTime = DateTime.parse(expirationTimeFromBox);
      expirationTime.log();
      DateTime.now().log();
      expirationTime.isBefore(DateTime.now()).log();
      if (expirationTime.isBefore(DateTime.now())) {
        // Delete the expired data and expiration time.
        'getFromLocalBox Deleting data'.log();
        dataBox.delete(labelKey);
        expirationBox.delete(labelKey);
        return null;
      } else {
        'getFromLocalBox Returning data'.log();
        return data;
      }
    } catch (e) {
      // Handle any errors that occur.
      'getFromLocalBox Error getting data from local box: $e'.log();
      //todo: throw exception
      return null;
    } finally {
      'getFromLocalBox Closing all open boxes'.log();
      Hive.close();
    }
  }

  Future<void> deleteDataAt(String labelKey) async {
    'deleteDataAt Opening boxes'.log();
    final expirationBox = await Hive.openBox<String>(_boxExpiration);
    final dataBox = await Hive.openBox(_boxData);

    'deleteDataAt Deleting data at $labelKey'.log();
    await expirationBox.delete(labelKey);
    await dataBox.delete(labelKey);

    'Closing all open boxes'.log();
    Hive.close();
  }
}
