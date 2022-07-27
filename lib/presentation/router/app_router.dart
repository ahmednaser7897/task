import 'package:flutter/material.dart';

import '../screens/shared/loge_in.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //case '/':
         //return MaterialPageRoute(builder: (_) =>  MyApp(appRouter: AppRouter(),));
       case '/login':
         return MaterialPageRoute(builder: (_) =>  LoginScreen());
      default:
        return null;
    }
  }
}