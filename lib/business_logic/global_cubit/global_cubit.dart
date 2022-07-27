import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/local/cache_helper.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState>{
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  bool langAr =CacheHelper.getDataFromSharedPreference(key: "ar") ??false;
  Future<void> changeLang() async {
    await CacheHelper.saveDataSharedPreference(key: "ar", value: !langAr);
    langAr=!langAr;
    emit(ChangeLang());
  }

}
