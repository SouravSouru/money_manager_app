import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/screens/drawer/screen_about.dart';
import 'package:money_management_app/screens/drawer/screen_rate_us.dart';
import 'package:money_management_app/screens/drawer/screen_settings.dart';
import 'package:money_management_app/screens/home/screen_home.dart';
import 'package:money_management_app/screens/splash/screen_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerHomeScreen extends StatelessWidget {
  const DrawerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.red),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ScreenHome()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_border, color: Colors.yellow),
            title: const Text("Rate Us"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => RateUs()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.purple),
            title: const Text("About Us"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ScreenAbout()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text("Settings"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ScreenSettings()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.refresh, color: Colors.green),
            title: const Text("Reset App"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Do You Want To Reset ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            TransactionDB().deleteAllTransaction();
                            CategoryDB().deleteAllCategory();
                            singOut(context);
                          },
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("No"),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
  singOut(context) async{
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    await prefrs.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx1)=>ScreenSplach(),), (route) => false);
  }
}
