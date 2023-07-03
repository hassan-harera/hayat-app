import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/repository/oauth/google/GoogleSignInButton.dart';
import 'package:hayat_eg/features/data/repository/oauth/google/oauth.dart';
import 'package:hayat_eg/features/presentation/page/signup/Register/register.dart';
import 'package:hayat_eg/features/presentation/page/signup/forgetPasswordFolder/forgetPassword/ForgetPassword.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat_layout.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:hayat_eg/shared/component/constants.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'LoginCubit/LoginCubit.dart';
import 'LoginCubit/LoginStates.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  var subjectController = TextEditingController();
  var passwordController = TextEditingController();
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  String? deviceToken;
  double progressNum = 0;

  int progressNumber() {
    var random = Random();
    var randomNumber = random.nextInt(41) + 40;
    print(randomNumber);
    return randomNumber;
  }

  @override
  void initState() {
    fcm.getToken().then((token) {
      deviceToken = token;
      print('the device token is :$token');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Cash_helper.setData(key: 'token', value: state.token);
            print(state.token);
            myNavigateAndFinish(context, const HayatLayoutScreen());
          } else if (state is LoginErrorState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(
                        state.error,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ));
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: size.height / 3,
                      width: double.infinity,
                      color: Colors.amber,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width / 2,
                                height: size.height / 5,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/slider.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "login".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 45,
                              ),
                              Form(
                                key: formKey,
                                autovalidateMode: autoValidateMode,
                                child: Column(
                                  children: [
                                    myTextFormField(
                                      label: ('Mobile,Email or username'),
                                      prefixIcon: (Icons.email_outlined),
                                      controller: subjectController,
                                      hint: '01XX-XXX-XXXX',
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This Field is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    myTextFormField(
                                      label: 'Password',
                                      hint: '* * * * * * * *',
                                      prefixIcon: Icons.lock_outline,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      suffixIcon: loginCubit.obscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      suffixColor: loginCubit.obscure
                                          ? Colors.grey
                                          : Colors.amber,
                                      obscure: loginCubit.obscure,
                                      suffixFunction: () {
                                        loginCubit.changeObscure();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password Is Required';
                                        }
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        defaultTextBottom(
                                            text: 'Forget Password?',
                                            function: () {
                                              myNavigator(context,
                                                  const forgetPasswordScreen());
                                            }),
                                      ],
                                    ),
                                    ConditionalBuilder(
                                      condition: state is LoginLoadingState,
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator()),
                                      fallback: (context) => myButton(
                                          text: 'login',
                                          onTap: () {
                                            onSubmitted(loginCubit);
                                          },
                                          radius: 30),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        //new one
                                        FutureBuilder(
                                          future: AuthenticationTest
                                              .initializeFirebase(
                                                  context: context),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return const Text(
                                                  'Error initializing Firebase');
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.done) {
                                              return Expanded(
                                                  child: GoogleSignInButton());
                                            }
                                            return Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      start: size.width / 8,
                                                      end: size.width / 8),
                                              child: CircularPercentIndicator(
                                                animation: true,
                                                animationDuration: 1000,
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.amber.shade200,
                                                percent: .99,
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                center: Text(
                                                  '${progressNumber()}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.amber),
                                                ),
                                                progressColor: Colors.amber,
                                                lineWidth: 5,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: size.width / 80,
                                        ),
                                        Expanded(
                                          child: OutlinedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/facebook.png"),
                                                      height: 30.0,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Text(
                                                          'facebook sign in',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an account?',style: TextStyle(fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black54
                              ),),
                                  defaultTextBottom(
                                      function: () {
                                        myNavigateAndReplacement(
                                            context, RegisterScreen());
                                      },
                                      text: 'Sign up'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onSubmitted(LoginCubit loginCubit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loginCubit.loginWithApi(
          subject: subjectController.text,
          password: passwordController.text,
          deviceToken: deviceToken);
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
