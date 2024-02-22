import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class customtoast{
  static void showToast(String msg)
  {
    Fluttertoast.showToast(
      msg:msg,
      fontSize:16.0,
      textColor:Colors.white,
      backgroundColor:Colors.teal,
      gravity:ToastGravity.BOTTOM,
      timeInSecForIosWeb:5,
    );
  }
}