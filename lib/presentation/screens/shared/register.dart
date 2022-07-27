import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task/presentation/screens/shared/loge_in.dart';
import 'package:task/presentation/widget/logein_and_register_widget.dart';

import '../../../business_logic/logein cupit/logein_states.dart';
import '../../../business_logic/logein cupit/login_cuoit.dart';
import '../../../data/models/account_model.dart';

import '../../widget/text_field.dart';
import '../../widget/toast.dart';
import '../user/user_profile.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();
    var confirmPassController = TextEditingController();
    
    var screanH = MediaQuery.of(context).size.height;
    var screanW = MediaQuery.of(context).size.width;
    
    return BlocProvider<LoginCupit>(
      create: (context) => LoginCupit(),
      child: BlocConsumer<LoginCupit, LoginState>(
        listener: (context, state) {
          LoginCupit cupit = LoginCupit.get(context);
          if (state is ScLoginState && cupit.loginModelRegiste.status == 200) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  UserProfile(account: cupit.loginModel.account!),
              ),
            );
          } else if (state is ErrorRegisteState) {
            if (!state.error.contains("Null")) {
              buildToast(context, state.error);
            } else {
              buildToast(
                  context,
                  cupit.langAr
                      ? "شي ما خطاء حاول مجددا"
                      : "Something wrong, try again");
            }

            print("state.error is " + state.error);
          }
        },
        builder: (context, state) {
          nameController.text = "ahmednaser";
          passController.text = confirmPassController.text = "123456";
          phoneController.text = "12345634568";
          emailController.text = "ahmed@gmail.com";
          LoginCupit cupit = LoginCupit.get(context);
          return Directionality(
            textDirection: cupit.langAr ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              body: Sizer(builder: (context, orientation, deviceType) {
                return SingleChildScrollView(
                  child: LogeinAndRegisterBackGround(
                    logein: false,
                    child: Form(
                      key: _formKey,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: (state is LodingRegisteState ||
                                    state is LodingLoginState)
                                ? const LinearProgressIndicator()
                                : null,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                registerForm(
                                    screanW,
                                    nameController,
                                    emailController,
                                    phoneController,
                                    passController,
                                    confirmPassController,
                                    context),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: screanH * 0.05,
                                ),
                                logeInAndRegisterRow(
                                  bouttonWidth: screanW * 0.4,
                                  context: context,
                                  logein: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  register: () {
                                    if (_formKey.currentState!.validate()) {
                                      Account account = Account(
                                          email: emailController.text,
                                          password: passController.text,
                                          phone: phoneController.text,
                                          name: nameController.text);
                                      cupit.registing(account: account);
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: screanH * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Column registerForm(
      double screanW,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController phoneController,
      TextEditingController passController,
      TextEditingController confirmPassController,
      BuildContext context) {
    LoginCupit cupit = LoginCupit.get(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screanW * 0.12),
          child: AppTextFormField(
            keyboardType: TextInputType.text,
            controller: nameController,
            title: cupit.langAr ? "الاسم بالكامل" : "Full Name",
            password: false,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return cupit.langAr
                    ? "من فضلك ادخل المطلوب"
                    : 'Please fill the field';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screanW * 0.12),
          child: AppTextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            title: cupit.langAr ? "البريد" : "Email",
            password: false,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return cupit.langAr
                    ? "من فضلك ادخل المطلوب"
                    : 'Please fill the field';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screanW * 0.12),
          child: AppTextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: phoneController,
            title: cupit.langAr ? "رقم الهاتف" : "Phone",
            password: false,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return cupit.langAr
                    ? "من فضلك ادخل المطلوب"
                    : 'Please fill the field';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screanW * 0.12),
          child: AppTextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passController,
            title: cupit.langAr ? "كلمه سر" : "Password",
            password: true,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return cupit.langAr
                    ? "من فضلك ادخل المطلوب"
                    : 'Please fill the field';
              }
              if (value.length < 6) {
                return cupit.langAr ? "غير صحيح" : 'Incorrect formula';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screanW * 0.12),
          child: AppTextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: confirmPassController,
            title: cupit.langAr ? "تاكيد كلمه السر" : "Confirm Password",
            password: true,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return cupit.langAr
                    ? "من فضلك ادخل المطلوب"
                    : 'Please fill the field';
              }
              if (value != passController.text) {
                return cupit.langAr
                    ? "كلمه سر غير صحيحه"
                    : 'Incorrect password';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
