import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/presentation/page/login/Login.dart';
import 'package:hayat_eg/features/presentation/page/signup/RegisterCubit/registerState.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:hayat_eg/shared/component/constants.dart';
import '../RegisterCubit/rigistrCubit.dart';
import '../phoneNumber/phoneNumberScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  // var mobilController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  // var passwordController = TextEditingController();
  // var repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          RegisterCubit registerCubit = RegisterCubit.get(context);
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
                      child: Center(
                        child: Text(
                          "Register".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(height: size.height / 50),
                                Form(
                                  key: formKey,
                                  autovalidateMode: autoValidateMode,
                                  child: Column(
                                    children: [
                                      defaultTextFormField(
                                        hint: ('First Name'),
                                        prefixIcon:
                                            (Icons.person_outline_outlined),
                                        controller: firstNameController,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return " First Name is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      defaultTextFormField(
                                        hint: ('Last Name'),
                                        prefixIcon:
                                            (Icons.person_outline_outlined),
                                        controller: lastNameController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return " last Name is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      ConditionalBuilder(
                                        condition:
                                            state is! RegisterLoadingState,
                                        builder: (context) => myButton(
                                            text: 'Next',
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState!.save();

                                                myNavigator(
                                                    context,
                                                    PhoneScreen(
                                                      firstNameController:
                                                          firstNameController
                                                              .text,
                                                      lastNameController:
                                                          lastNameController
                                                              .text,
                                                    ));
                                              } else {
                                                autoValidateMode =
                                                    AutovalidateMode.always;
                                              }
                                            },
                                            radius: 30),
                                        fallback: (context) => const Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Do have an account Already?'),
                                    defaultTextBottom(
                                        function: () {
                                          myNavigator(context, LoginScreen());
                                        },
                                        text: 'Sign in'),
                                    SizedBox(
                                      height: size.height / 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//Content-Type
//Content-Type
