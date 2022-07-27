import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FToast fToast = FToast();
showMyToast(String? text) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      //color: AppColors.lightGray,
    ),
    child: Text(text!),
  );

  fToast.showToast(
    positionedToastBuilder: (context, child) {
      return child;
    },
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}

void buildToast(BuildContext ctx,String text,) {
    showToast(
      text,
      textStyle: const TextStyle(color: Colors.white),
      context: ctx,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
}