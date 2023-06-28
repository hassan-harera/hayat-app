import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat-egLayout.dart';
import 'package:hayat_eg/modules/StartApp/on_bording/on_bording_layout.dart';
import 'package:hayat_eg/shared/BlocObserver.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/DioHelper.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:hayat_eg/styles/thems.dart';

import 'firebase_options.dart';
import 'modules/StartApp/login/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Cash_helper.init();
  Widget? widget;
  bool? onBoarding = Cash_helper.getData(key: 'onBoarding');
  String? token = Cash_helper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const HayatLayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  // widget = const TestScreen();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThem,
      darkTheme: darkThem,
      themeMode: ThemeMode.light,
      home: LoginScreen(),
    );
  }
}
