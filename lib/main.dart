import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:hayat_eg/layout/HayatLayout/hayat-egLayout.dart';
import 'package:hayat_eg/modules/StartApp/on_bording/onBordingLayout.dart';
import 'package:hayat_eg/shared/BlocObserver.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/DioHelper.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:hayat_eg/styles/thems.dart';
import 'package:hayat_eg/test.dart';
import 'package:hayat_eg/widgets/QR%20code/ScaneQR.dart';
import 'firebase_options.dart';

import 'layout/Categories/BookCatiogryScreen.dart';
import 'layout/Categories/test.dart';
import 'layout/LayoutScreens/ItemScreen/ItemScreen.dart';
import 'modules/StartApp/Splash/Splash_view.dart';
import 'modules/StartApp/login/Login.dart';
import 'modules/StartApp/registerScreen/Register/register.dart';
import 'modules/StartApp/registerScreen/forgetPasswordFolder/forgetPassword/ForgetPassword.dart';

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
