import 'package:flutter/material.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/screens/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenWelcome extends StatelessWidget {
   ScreenWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Image.asset("assets/welcome.jpg"),
            Text("Let's Save Your Money",style: TextStyle(fontWeight: FontWeight.bold),),
            ElevatedButton(onPressed: (){
              isLogged(context);
            }, child: Text("Let's Save"),),
          ],
        ),
      ),
    );
  }

  Future<void> isLogged(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SAVE_KEY_NAME, true);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ScreenHome()));
  }
}
