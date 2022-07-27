
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/presentation/screens/shared/register.dart';
import 'package:task/presentation/screens/user/user_profile.dart';
import 'package:task/presentation/widget/text_field.dart';

import '../../../business_logic/logein cupit/logein_states.dart';
import '../../../business_logic/logein cupit/login_cuoit.dart';
import '../../widget/logein_and_register_widget.dart';
import '../../widget/toast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
   
    var screanH = MediaQuery.of(context).size.height;
    var screanW = MediaQuery.of(context).size.width;
    return BlocProvider<LoginCupit>(
      create: (context) => LoginCupit(),
      child: BlocConsumer<LoginCupit, LoginState>(
        listener: (context, state)  {
          LoginCupit cupit = LoginCupit.get(context);
          if (state is ScLoginState) {
              //cupit.saveLogeinData("logein");
             Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfile(account: cupit.loginModel.account!),
          ),
        );   
        } else if (state is ErrorLoginState) {
            if(!state.error.contains("Null")){
               buildToast(context, state.error);
            }else{
              buildToast(context,cupit.langAr?"شي ما خطاء حاول مجددا": "Something wrong, try again");
            }
            print("state.error is " + state.error);
          }
        },
        builder: (context, state) {
          emailController.text = "ahmed@gmail.com";
          passController.text = "123456";
          LoginCupit cupit = LoginCupit.get(context);
          return SafeArea(
            child: Directionality(
              textDirection: cupit.langAr?TextDirection.rtl:TextDirection.ltr,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: LogeinAndRegisterBackGround(
                    child: Form(
                      key: _formKey,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child:(state is LodingLoginState) ?
                              const LinearProgressIndicator():null ,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: screanW * 0.12),
                                    child: AppTextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      title:cupit.langAr?"بريد": "Email",
                                      password: false,
                                      validator: (String? value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return cupit.langAr?"من فضلك ادخل المطلوب":'Please fill the field';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: screanW * 0.12),
                                    child: AppTextFormField(
                                      keyboardType: TextInputType.visiblePassword,
                                      controller: passController,
                                      title:cupit.langAr?"كلمه السر": "Password",
                                      password: true,
                                      validator: (String? value) {
                                        if (value == null || value.trim().isEmpty) {
                                           return cupit.langAr?"من فضلك ادخل المطلوب":'Please fill the field';
                                        }
                  
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              logeInAndRegisterRow(
                                bouttonHeight: screanH * 0.07,
                                bouttonWidth: screanW * 0.4,
                                context: context,
                                logein: () async {
                                  if (_formKey.currentState!.validate()) {
                                     await cupit.myUserLogin(
                                        email: emailController.text,
                                        pass: passController.text);
                                  }
                                },
                                register: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  Register(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
