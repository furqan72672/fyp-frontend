import 'package:flutter/material.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/views/auth/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationDialog extends StatelessWidget {
  var text;
  var cancelText;
  var confirmText;
  var originalContext;
  ConfirmationDialog({Key? key,required this.text,required this.cancelText,required this.confirmText,required this.originalContext}) : super(key: key);


  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text(this.cancelText)),
          ElevatedButton(onPressed: ()async{
            // CustomDialog().notShow(context);
            // CustomDialog().show(text: "Logging Out...",context: context);
            SharedPreferences prefs=await SharedPreferences.getInstance();
            prefs.clear();
            // CustomDialog().notShow(context);
            Navigator.pop(context);
            Navigator.of(originalContext).pushReplacement(MaterialPageRoute(builder: (ctx)=>LandingPage()));
          }, child: Text(this.confirmText)),
        ],
        content: Text(this.text),
      );
  }
}
