import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task/data/models/account_model.dart';
import 'package:task/presentation/styles/colors.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../widget/button.dart';
import '../shared/loge_in.dart';

class UserProfile extends StatelessWidget {
  final Account account;
  const UserProfile({
    Key? key,required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener:(context, state) {} ,
      builder: (context, state) {
        GlobalCubit cupit = GlobalCubit.get(context);
        //cupit.getUserData(email: "",pass: "");
        return Sizer(
          builder:  (context, orientation, deviceType) {
            TextStyle style= TextStyle(color: AppColor.blue, fontSize: 20.sp);
            return Directionality(
              textDirection: cupit.langAr?TextDirection.rtl:TextDirection.ltr,
              child: Scaffold(
                appBar: AppBar(
                    toolbarHeight:8.h ,
                    backgroundColor: AppColor.blue,
                    title:  FittedBox(
                      child: Text(
                         cupit.langAr?"بيانات المستخدم" :"User Data",
                        style:const TextStyle(fontSize: 20),
                      ),
                    ),
                    centerTitle: true
                ),
                body:
                  Container(
                    padding:const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                           height:orientation==Orientation.portrait?
                           15.h:5.h
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cupit.langAr?"الاسم : "+account.name!:
                              "Name : " +account.name!,
                              style:
                                   style,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                               cupit.langAr?"البريد : "+account.email!:
                              "Email : " +account.email!,
                              overflow:TextOverflow.ellipsis ,
                              maxLines: 2,
                              style:
                                   style,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                               cupit.langAr?"رقم الهاتف : "+account.phone!:
                              "Phone : " +account.phone!,
                              style:
                                   style,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height:orientation==Orientation.portrait?
                          30.h :2.h
                        ),
                        AppButton(
                          color: AppColor.red,
                          text: cupit.langAr?"تسجيل خروج": "LogOut",
                          width: 40.w,
                          height: 8.h,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
              ),
            );
          }
        );
      }
    );
  }

  
}
