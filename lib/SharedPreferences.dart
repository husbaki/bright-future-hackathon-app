import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveUserDetails(String email, String fullName, String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('fullName', fullName);
    await prefs.setString('username', username);
    await prefs.setString('password', password); // Обычно пароли не хранятся в открытом виде
  }

  static Future<Map<String, String?>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('email'),
      'fullName': prefs.getString('fullName'),
      'username': prefs.getString('username'),
      'password': prefs.getString('password'), // Опять же, лучше использовать хэширование для паролей
    };
  }

  static Future<void> clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('fullName');
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.setBool('isRegistered', false);
  }

  static Future<void> setRegistered(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', value);
  }

  static Future<bool> isRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isRegistered') ?? false;
  }
}
