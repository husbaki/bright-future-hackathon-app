import 'package:flutter/material.dart';
import 'SharedPreferences.dart';
import 'pageControl.dart';
import 'signUp.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool _isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  _checkRegistrationStatus() async {
    bool isRegistered = await UserPreferences.isRegistered();
    setState(() {
      _isRegistered = isRegistered;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isRegistered) {
      return MainPage();
    } else {
      return SignUpPage();
    }
  }
}
