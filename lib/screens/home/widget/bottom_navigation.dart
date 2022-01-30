import 'package:flutter/material.dart';
import 'package:money_management_app/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectIndexNotifer,
      builder: (BuildContext ctx, int updatedIdex,Widget?_) {
        return BottomNavigationBar(
          currentIndex: updatedIdex,
          onTap: (newIndex){
            ScreenHome.selectIndexNotifer.value =newIndex;
          },
          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Transactions"),
            BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category"),
          ],
        );
      }
    );
  }
}