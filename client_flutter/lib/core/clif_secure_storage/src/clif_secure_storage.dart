import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core.dart';

final class CLIFSecureStorage {
  CLIFSecureStorage._();

  static const _location = 'CLIFSecureStorage';
  static final _instance = CLIFSecureStorage._();
  static CLIFSecureStorage get instance => _instance;

  final _storage = const FlutterSecureStorage();

  /// Saves a given string or null value in secure storage under a specified key.
  /// If the value is null, it stores the string "null".
  /// 
  /// Example:
  ///   - Store a string: `write(key: 'myKey', value: 'myValue')`
  ///   - Store null: `write(key: 'myNullKey', value: null)`
  Future<void> write({required String key, required String? value}) {
    CLIFLogger.debug(location: _location, message: 'Writing value: $value with key: $key');
    return _storage.write(key: key, value: value);
  }

  /// Retrieves and converts a string value from secure storage to a specified type.
  /// If key is not found, conversion fails, or an error occurs, returns null.
  /// 
  /// Example:
  ///   - Convert to integer: `read<int>(key: 'myIntKey', converter: int.tryParse)`
  ///   - Convert to custom object: `read<MyObject>(key: 'myObjectKey', converter: MyObject.fromJson)`
  /// 
  /// Logs an error and returns null if reading operation fails.
  Future<T?> read<T extends Object>({required String key, required T Function(String rawString) converter}) async {
    try {
      final response = await _storage.read(key: key);
      CLIFLogger.debug(location: _location, message: 'Read value with key - $key. Got: $response');
      if (response == null) {
        return null;
      }
      return converter(response);
    } catch (e) {
      CLIFLogger.error(
        location: _location,
        message: 'Error reading value with key $key',
        errorObject: e,
      );
    }
    return null;
  }

  /// Removes a value from secure storage associated with a specified key.
  /// Does nothing if the key doesn't exist.
  /// 
  /// Example:
  ///   - Delete a value: `delete(key: 'myKey')`
  /// 
  /// Logs the action and completes after removal.
  Future<void> delete({required String key}) {
    CLIFLogger.debug(location: _location, message: 'Deleting value with key - $key');
    return _storage.delete(key: key);
  }
}
