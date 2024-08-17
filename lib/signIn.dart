import 'package:flutter/material.dart';
import 'signup.dart'; // Импортируйте файл с экраном регистрации

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255), // Полупрозрачный фиолетовый
              Color.fromARGB(255, 205, 177, 255), // Белый
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 80.0, 24.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 24.0),
                      child: Image.asset(
                        'assets/logo.png', // Замените на путь к вашему логотипу
                        height: 100,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Starter',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Consolas',
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'WELCOME BACK',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Consolas',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 70), // Промежуток между блоком с надписями и полем ввода

                // Поля ввода
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Username or Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(fontFamily: 'Consolas'),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(fontFamily: 'Consolas'),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100), // Уменьшите горизонтальное значение, чтобы кнопка была по центру
                    ),
                    child: Text('Log In', style: TextStyle(fontFamily: 'Consolas')),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?', style: TextStyle(fontFamily: 'Consolas')),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(fontFamily: 'Consolas')),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()), // Переход на экран регистрации
                        );
                      },
                      child: Text('Sign Up', style: TextStyle(fontFamily: 'Consolas')),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
