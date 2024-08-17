import 'package:flutter/material.dart';
import 'SharedPreferences.dart';
import 'pageControl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signIn.dart'; // Импортируйте файл с экраном входа

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUp() async {
    String email = emailController.text;
    String fullName = fullNameController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    // Сохранение данных пользователя в SharedPreferences
    await UserPreferences.saveUserDetails(email, fullName, username, password);
    await UserPreferences.setRegistered(true);

    // Отправка данных на сервер
    var success = await _sendDataToServer(email, fullName, username, password);

    if (success) {
      // Переход на главную страницу
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      // Обработка ошибки при отправке на сервер
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error', style: TextStyle(fontFamily: 'Consolas')),
          content: Text('Failed to register user. Please try again later.', style: TextStyle(fontFamily: 'Consolas')),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontFamily: 'Consolas')),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> _sendDataToServer(
      String email, String fullName, String username, String password) async {
    var url = Uri.parse('http://192.168.1.146:8081/users');

    var name, surname = fullName.split(" ");

    // Создание JSON объекта с данными пользователя
    var userData = {
      'name': name,
      'surname': surname, // Если не используется, можно оставить пустым
      'email': email,
      'password': password,
    };

    // Преобразование JSON в строку
    var jsonBody = json.encode(userData);

    try {
      // Отправка POST запроса на сервер
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      // Проверка статуса ответа
      if (response.statusCode == 201) {
        // Пользователь успешно зарегистрирован на сервере
        print('User registered successfully on server');
        return true;
      } else {
        // Ошибка при регистрации пользователя на сервере
        print('Failed to register user on server');
        return false;
      }
    } catch (e) {
      // Обработка ошибок сети или других исключений
      print('Exception while registering user: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255), // Фиолетовый цвет с меньшей прозрачностью
              Color.fromARGB(255, 205, 177, 255), // Белый цвет
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 24.0),
                          child: Image.asset(
                            'assets/logo.png',
                            height: 100,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Starter',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Consolas',
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'WELCOME',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Consolas',
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Белый цвет фона
                      ),
                      style: TextStyle(fontFamily: 'Consolas'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Белый цвет фона
                      ),
                      style: TextStyle(fontFamily: 'Consolas'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Белый цвет фона
                      ),
                      style: TextStyle(fontFamily: 'Consolas'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Белый цвет фона
                      ),
                      style: TextStyle(fontFamily: 'Consolas'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 160),
                      ),
                      child: const Text('Sign Up', style: TextStyle(fontFamily: 'Consolas')),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?", style: TextStyle(fontFamily: 'Consolas')),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text('Log In', style: TextStyle(fontFamily: 'Consolas')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
