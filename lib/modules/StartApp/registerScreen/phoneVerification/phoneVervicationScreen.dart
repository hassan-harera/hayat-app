import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/shared/component/component.dart';

import '../../../../shared/component/constans.dart';
import '../RegisterCubit/registerState.dart';
import '../RegisterCubit/rigistrCubit.dart';
import '../SetPassword/SetPassword.dart';

class PhoneVerificationScreen extends StatelessWidget {
  PhoneVerificationScreen(
      {super.key,
      required this.mobilController,
      required this.firstNameController,
      required this.lastNameController});

  final String mobilController;
  final String firstNameController;
  final String lastNameController;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();
  bool obscure = false;
  var verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is OTPVerificationRegisterSuccessState) {
            myNavigator(
                context,
                setPasswordScreen(
                  otp: verificationController.text,
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  mobilController: mobilController,
                ));
          } else if (state is OTPVerificationRegisterErrorState) {
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
          RegisterCubit registerCubit = RegisterCubit.get(context);
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
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            bottom: 30, end: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              fit: StackFit.loose,
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(),
                                  child: Image.asset(
                                    'assets/unlocked.png',
                                    scale: 2.7,
                                    width: 180,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Phone Verification ',
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
                        'Please Enter The Sent Verification Code',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Verification Code',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        autovalidateMode: autoValidateMode,
                        child: myStaticTextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ' Please Enter Code';
                            } else if (value.length != 6) {
                              return ' Please Enter Correct code';
                            }
                          },
                          prefixIcon: CupertinoIcons.person,
                          hint: '******',
                          controller: verificationController,
                          filled: true,
                          keyboardType: TextInputType.number,
                          obscure: obscure,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      myButton(
                          text: 'Verify',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              registerCubit.oTPVerificationRegister(
                                  mobile: mobilController,
                                  otp: verificationController.text);

                              formKey.currentState!.save();
                            } else {
                              autoValidateMode = AutovalidateMode.always;
                            }
                          },
                          radius: 30),
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
