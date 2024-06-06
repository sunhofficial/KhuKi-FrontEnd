import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccessTokenProvider {
  final FlutterSecureStorage _storage;
  String? _accessToken;

  AccessTokenProvider(this._storage);

  Future<String?> get accessToken async {
    return await _storage.read(key: "accessToken");
  }

  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    await _storage.write(key: "accessToken", value: token);
  }

  Future<void> clearAccessToken() async {
    _accessToken = null;
    await _storage.delete(key: "accessToken");
  }
}
