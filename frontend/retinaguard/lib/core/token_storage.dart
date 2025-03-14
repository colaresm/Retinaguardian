import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:retinaguard/data/models/user_informations_model.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveUserInformations(
      UserInformationsModel userInformationsModel) async {
    await _storage.write(key: 'user_id', value: userInformationsModel.userId);
    await _storage.write(
        key: 'access_token', value: userInformationsModel.accessToken);
  }

  static Future<String?> getUserId() async {
    String userId = await _storage.read(key: 'user_id') ?? "";
    return userId;
  }

  static Future<String?> getAccessToken() async {
    String accessToken = await _storage.read(key: 'access_token') ?? "";
    return accessToken;
  }

  static Future<void> deleteUserInformations() async {
    await _storage.delete(key: 'access_token');
  }
}
