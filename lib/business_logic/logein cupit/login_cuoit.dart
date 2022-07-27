

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/constants/end_points.dart';

import '../../data/local/cache_helper.dart';
import '../../data/models/account_model.dart';

import '../../data/remote/dio_helper.dart';
import 'logein_states.dart';

class LoginCupit extends Cubit<LoginState> {
  LoginCupit() : super(IntiLoginState());

  static LoginCupit get(context) => BlocProvider.of(context);
  late AccountModel loginModel;
  bool langAr =CacheHelper.getDataFromSharedPreference(key: "ar") ??false;
  Future<void> changeLang() async {
    await CacheHelper.saveDataSharedPreference(key: "ar", value: !langAr);
    langAr=!langAr;
    emit(ChangeLang());
  }

  myUserLogin({required String email, required String pass})  async {
    emit(LodingLoginState());
    await DioHelper.postData(url: logeIn, body: {
      'email': email,
      'password': pass,
    }).then((value) {
      if (value.data['status'] != 200) {
        print(
            'error from user login function state is ${value.data['status']}}');
        emit(ErrorLoginState(value.data['message']));
      } else {
        loginModel = AccountModel.fromJson(value.data);
        print(loginModel.account!.email);
        emit(ScLoginState());
      }
    }).catchError((onError) {
      print('error from user login function ${onError.toString()}');
    });
  }

  late AccountModel loginModelRegiste;
  void registing({required Account account}) async {
    emit(LodingRegisteState());
    await DioHelper.postData(url: register, body: {
      'email': account.email,
      'password': account.password,
      'name': account.name,
      'phone': account.phone,
    }).then((value) async {
      if (value.data['status'] != 200) {
        print(
            'error from user registerLogin function state is ${value.data['status']}}');
        emit(ErrorRegisteState(value.data['message']));
      } else {
        loginModelRegiste = AccountModel.fromJson(value.data);
        await myUserLogin(email: account.email!, pass: account.password!);
        print("loginModelRegiste status is " +
            loginModelRegiste.status.toString());
        emit(ScRegisteState());
      }
    }).catchError((onError) {
      print('error from user REGISTER function ${onError.toString()}');
      emit(ErrorRegisteState(onError.toString()));
    });
  }

   
}
