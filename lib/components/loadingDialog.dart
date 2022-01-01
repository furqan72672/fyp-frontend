import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  var text;
  LoadingDialog({Key? key,required this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
      return AlertDialog(

        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(this.text),
            CircularProgressIndicator(),
          ],
        ),
      );
  }
}
