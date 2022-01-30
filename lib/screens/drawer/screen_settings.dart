import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/screens/splash/screen_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              "Reset Categories",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.refresh),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Do You Want To Reset ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            CategoryDB().deleteAllCategory();
                            Navigator.of(context).pop();
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
          ListTile(
            title: const Text("Reset Transactions",
                style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.refresh),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Do You Want To Reset ?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            TransactionDB().deleteAllTransaction();
                            Navigator.of(context).pop();
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
          ListTile(
            title: const Text(
              "Reset App",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.refresh),
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
