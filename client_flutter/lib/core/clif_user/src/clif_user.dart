import '../../core.dart';

final class CLIFUser {
  CLIFUser._();

  static final _instance = CLIFUser._();
  static CLIFUser get instance => _instance;

  Future<String?> get token {
    return CLIFSecureStorage.instance.read(key: 'token', converter: (rawString) => rawString);
  }

  Future<void> writeToken(String token) async {
    CLIFSecureStorage.instance.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    CLIFSecureStorage.instance.delete(key: 'token');
  }
}
