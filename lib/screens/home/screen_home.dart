import 'package:flutter/material.dart';
import 'package:money_management_app/screens/category/category_add_popup.dart';
import 'package:money_management_app/screens/category/screen_category.dart';
import 'package:money_management_app/screens/home/widget/bottom_navigation.dart';
import 'package:money_management_app/screens/drawer/drawer.dart';
import 'package:money_management_app/screens/transaction/screen_add_transaction.dart';
import 'package:money_management_app/screens/transaction/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectIndexNotifer = ValueNotifier(0);
  final pages = [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHomeScreen(),
      appBar: AppBar(
        title: Text("Money Manager"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectIndexNotifer,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectIndexNotifer.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            print("Add Transactions");
          } else {

            showCategoryAddPopup(context);
            // final sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: "travel",
            //   type: CategoryType.income,
            // );

            // CategoryDB().insertCategory(sample);
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
