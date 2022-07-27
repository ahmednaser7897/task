// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/presentation/widget/button.dart';

import '../../business_logic/logein cupit/login_cuoit.dart';
import '../styles/colors.dart';

class LogeinAndRegisterBackGround extends StatelessWidget {
  const LogeinAndRegisterBackGround({ Key? key ,required this.child, this.logein=true}) : super(key: key);
  final Widget child;
  final bool logein;
  @override
  Widget build(BuildContext context) {
    var screanH = MediaQuery.of(context).size.height;
    var screanW = MediaQuery.of(context).size.width;
    LoginCupit cupit = LoginCupit.get(context);
    const double borderRadius = 30;
    return Container(
        color: AppColor.blue,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screanH * 0.28,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  SizedBox(
                      width: screanW * 0.4,
                      height: screanH * 0.32,
                      child: Image.asset(
                        "assets/images/logo2.png",
                        fit: BoxFit.cover,
                      )),
                  if(logein)
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        top: screanH * 0.05, end: screanW * 0.04),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: AppButton(
                          color: AppColor.white,
                          text:!cupit.langAr? "عربي":"english",
                          textColor: AppColor.blue,
                          width: screanW * 0.25,
                          height: screanH * 0.04,
                          pading: true,
                          onTap: () {
                            cupit.changeLang();
                            print("chang lang");
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: screanH * 0.72,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: child
            )
          ],
        ),
        );
  }
}

Widget logeInAndRegisterRow({required Function register,required Function logein,required double bouttonWidth, double bouttonHeight=50 ,required BuildContext context}){
  LoginCupit cupit = LoginCupit.get(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      AppButton(
          color: AppColor.blue,
          text:cupit.langAr?"انشاء حساب": "Register",
          width: bouttonWidth,
          height:bouttonHeight,
          onTap: () {
           register();
          }),
      AppButton(
        color: AppColor.blue,
        text: cupit.langAr?"سجل دخول":"Login",
        width:bouttonWidth,
        height: bouttonHeight,
        onTap: () {
         logein();
        },
      ),
    ],
  );         
}