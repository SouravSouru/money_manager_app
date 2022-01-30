

import 'package:flutter/material.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/screens/home/screen_home.dart';
import 'package:money_management_app/screens/welcome/screen_welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplach extends StatefulWidget {
  const ScreenSplach({Key? key}) : super(key: key);

  @override
  _ScreenSplachState createState() => _ScreenSplachState();
}

class _ScreenSplachState extends State<ScreenSplach> {

  @override
  void initState() {
     checkUserLoggedIn();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/splash.png",
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }

  Future<void> gotoWelcomeScreen() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => ScreenWelcome()));
  }

  Future<void> checkUserLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _userLongedIn = prefs.getBool(SAVE_KEY_NAME);
    if (_userLongedIn == null || _userLongedIn == false) {
      gotoWelcomeScreen();
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1)=>ScreenHome()));
    }
  }
}
