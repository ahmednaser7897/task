import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:task/business_logic/bloc_observer.dart';
import 'package:task/business_logic/global_cubit/global_cubit.dart';
import 'package:task/data/local/cache_helper.dart';

import 'package:task/data/remote/dio_helper.dart';
import 'package:task/presentation/screens/shared/loge_in.dart';
import 'package:task/presentation/widget/toast.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';


import 'presentation/screens/user/user_profile.dart';


late LocalizationDelegate delegate;
//String sharedId="id";

//int myId=-1;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  BlocOverrides.runZoned(
        () async {
      
      final locale =
          CacheHelper.getDataFromSharedPreference(key: 'language') ?? "en";
      
      
      delegate = await LocalizationDelegate.create(
        fallbackLocale: locale,
        supportedLocales: ['ar', 'en'],
      );
      await delegate.changeLocale(Locale(locale));
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  

 // final AppRouter appRouter;

  const MyApp({
    //required this.appRouter,
    Key? key, 
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Intl.defaultLocale = delegate.currentLocale.languageCode;
    delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        buildToast(context,e.toString());
        //showToast(e.toString());
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => GlobalCubit()),
        ),
      ],
      child: Sizer(
            builder: (context, orientation, deviceType) {
              return LocalizedApp(

                delegate,
                LayoutBuilder(builder: (context, constraints) {
                  return MaterialApp(
                    home:SafeArea(child:LoginScreen()),
                    debugShowCheckedModeBanner: false,
                    title: 'Werash',
                    localizationsDelegates: [
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      delegate,
                    ],
                    locale: delegate.currentLocale,
                    supportedLocales: delegate.supportedLocales,
                    //onGenerateRoute: widget.appRouter.onGenerateRoute,
                    theme: ThemeData(
                      fontFamily: 'cairo',
                      //scaffoldBackgroundColor: AppColors.white,
                      appBarTheme: const AppBarTheme(
                        elevation: 0.0,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          //statusBarColor: AppColors.transparent,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                      ),
                    ),
                  );
                }),
              );
              
            },
      
      )
        
    );
  }
}