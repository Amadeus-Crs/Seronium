import 'package:flutter/material.dart';

class ToastUtils {
  static bool ShowLoading = false;
  static void showToast(BuildContext context, String? message) {
    if(ShowLoading){
      return ;
    }
    ShowLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      ShowLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(
          message ?? "发生错误",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      )
    );
  }
}