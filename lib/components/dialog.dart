import 'package:flutter/material.dart';
import 'package:fyp_ims/components/confirmationDialog.dart';
import 'package:fyp_ims/components/loadingDialog.dart';

class CustomDialog{
  show({text,context}){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx){
        return LoadingDialog(text: text,);
      }
    );
  }
  showConfirmation({text,confirmText,cancelText,context}){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx){
          return ConfirmationDialog(text: text,cancelText: cancelText,confirmText: confirmText,originalContext: context,);
        }
    );
  }
  notShow(context){
    Navigator.of(context).pop();
  }
}