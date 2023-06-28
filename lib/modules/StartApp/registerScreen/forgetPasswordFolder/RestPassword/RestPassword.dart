import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/shared/component/component.dart';
import '../../../../../shared/component/constans.dart';

import '../../../login/Login.dart';
import '../../RegisterCubit/registerState.dart';
import '../../RegisterCubit/rigistrCubit.dart';
import '../ForgetPasswordCubit/ForgetPasswordCubit.dart';
import '../ForgetPasswordCubit/forgetPasswordState.dart';

class resetPasswordScreen extends StatefulWidget {
  resetPasswordScreen({required this.phoneNum, required this.otp});

  final String phoneNum;
  final String otp;

  @override
  State<resetPasswordScreen> createState() => _resetPasswordScreenState();
}

class _resetPasswordScreenState extends State<resetPasswordScreen> {
  var formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  var reset1PasswordController = TextEditingController();
  var numberController = TextEditingController();

  var reset2PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            myNavigateAndFinish(context, LoginScreen());
          } else if (state is ForgetPasswordErrorState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ));
          }
        },
        builder: (context, state) {
          ForgetPasswordCubit forgetPasswordCubit =
              ForgetPasswordCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: backIcon(context),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Image.asset(
                                'assets/lock.png',
                                scale: 1.7,
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 33, bottom: 10),
                                child: Icon(
                                  Icons.check,
                                  size: 80,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Please Enter A Strong Password',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        autovalidateMode: autoValidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myStaticTextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return ' password is too short';
                                  }
                                },
                                controller: reset1PasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Icons.lock_outline,
                                hint: '**********',
                                obscure: forgetPasswordCubit.obscure1,
                                suffixIcon: forgetPasswordCubit.obscure1
                                    ? (Icons.visibility_off)
                                    : (Icons.visibility),
                                suffixFunction: () {
                                  forgetPasswordCubit.changeObscure1();
                                },
                                suffixColor: forgetPasswordCubit.obscure1
                                    ? Colors.grey
                                    : Colors.amber),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Re-Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myStaticTextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return ' password is too short';
                                  } else if (reset1PasswordController.text !=
                                      reset2PasswordController.text) {
                                    return 'Password is different';
                                  }
                                },
                                controller: reset2PasswordController,
                                obscure: forgetPasswordCubit.obscure2,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Icons.lock_outline,
                                hint: '**********',
                                suffixIcon: forgetPasswordCubit.obscure2
                                    ? (Icons.visibility_off)
                                    : (Icons.visibility),
                                suffixFunction: () {
                                  forgetPasswordCubit.changeObscure2();
                                },
                                suffixColor: forgetPasswordCubit.obscure2
                                    ? Colors.grey
                                    : Colors.amber),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                        condition: state is! ForgetPasswordLoadingState,
                        builder: (context) => myButton(
                            text: 'Next',
                            onTap: () {
                              print(widget.otp);
                              print(widget.phoneNum);
                              print(reset2PasswordController.text);
                              if (formKey.currentState!.validate()) {
                                forgetPasswordCubit.forgetPasswordWithApi(
                                    mobile: widget.phoneNum,
                                    newPassword: reset2PasswordController.text,
                                    otp: widget.otp);
                                formKey.currentState!.save();
                              } else {
                                setState(() {});
                                autoValidateMode = AutovalidateMode.always;
                              }
                            },
                            radius: 30),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
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
