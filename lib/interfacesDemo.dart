import 'package:flutter/material.dart';
import 'package:fyp_ims/adminHomePage.dart';
import 'package:fyp_ims/managerHomePage.dart';
import 'package:fyp_ims/salesmanHomePage.dart';

class InterfacesDemo extends StatelessWidget {
  const InterfacesDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("For Demo, Not to be included in final"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => SalesmanHomePage()));
            }, child: Text("To Salesman")),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => ManagerHomePage()));
            }, child: Text("To Manager")),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => AdminHomePage()));
            }, child: Text("To Admin")),
          ],
        ),
      ),
    );
  }
}
