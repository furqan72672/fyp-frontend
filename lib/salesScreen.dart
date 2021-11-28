import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon:Icon(Icons.search),onPressed: (){},),
              DropdownButton(
                  icon: Icon(Icons.arrow_drop_down),
                  items: [
                DropdownMenuItem(child: Text("123")),
                DropdownMenuItem(child: Text("789")),
                DropdownMenuItem(child: Text("456")),
              ])
            ],
          )
        ),
      ),
    );
  }
}
