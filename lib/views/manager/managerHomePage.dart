import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:fyp_ims/views/manager/attendanceScreen.dart';
import 'package:fyp_ims/views/manager/requestsScreen.dart';
import 'package:fyp_ims/views/manager/salesScreen.dart';
import 'package:fyp_ims/views/manager/stockScreen.dart';

class ManagerHomePage extends StatefulWidget {
  User user;
  ManagerHomePage({Key? key,required this.user}) : super(key: key);

  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {

  int cIndex=0;
  final screens=[
    StockScreen(),
    SalesScreen(),
    RequestScreen(),
    AttendanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Sales Alibi"),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            CustomDialog().showConfirmation(text: "Are you sure you want to logout?",context: context,cancelText: "No",confirmText: "Yes");
          }, child: Text("Logout",style: TextStyle(color: Colors.white),),)
        ],
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              cIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.indigo.shade900,
          currentIndex: cIndex,
          selectedItemColor: Colors.blueGrey,
          selectedIconTheme:
          IconThemeData(color: Colors.blueGrey, size: 30.0),
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey,
          unselectedIconTheme:
          IconThemeData(color: Colors.grey, size: 20.0),
          showUnselectedLabels: true,
          unselectedFontSize: 18.0,
          selectedFontSize: 18.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.storefront,
                ),
                label: "Stock",
                backgroundColor: Colors.indigo.shade900
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_shopping_cart,
                ),
                label: "Sales",
                backgroundColor: Colors.indigo.shade900
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.find_replace,
                ),
                label: "Requests",
                backgroundColor: Colors.indigo.shade900
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.location_solid,
                ),
                label: "Attendance",
                backgroundColor: Colors.indigo.shade900
            )
          ],
        ),
      ),
      body: screens[cIndex],
    );
  }
}
