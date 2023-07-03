import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat_layout.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:hayat_eg/shared/component/constants.dart';
import '../RegisterCubit/registerState.dart';
import '../RegisterCubit/register_cubit.dart';

class setPasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  setPasswordScreen(
      {super.key,
      required this.mobilController,
      required this.firstNameController,
      required this.lastNameController,
      required this.otp});

  final String mobilController;
  final String firstNameController;
  final String lastNameController;
  final String otp;
  var set1PasswordController = TextEditingController();
  var set2PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            myNavigateAndFinish(context, const HayatLayoutScreen());
          } else if (state is RegisterErrorState) {
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
          return AbsorbPointer(
            absorbing: state is RegisterLoadingState ? true : false,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
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
                            'set Password',
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
                                requiredTextField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return ' password is too short';
                                      }
                                    },
                                    hint: '**********',
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon: CupertinoIcons.lock_open,
                                    controller: set1PasswordController,
                                    obscure: registerCubit.obscure1,
                                    suffixColor: registerCubit.obscure2
                                        ? Colors.amber
                                        : Colors.grey,
                                    suffixIcon: registerCubit.obscure1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    suffixFunction: () {
                                      registerCubit.changeObscure1();
                                    }),
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
                                requiredTextField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return ' password is too short';
                                      }
                                    },
                                    hint: '**********',
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon: CupertinoIcons.lock,
                                    controller: set2PasswordController,
                                    obscure: registerCubit.obscure2,
                                    suffixColor: registerCubit.obscure2
                                        ? Colors.amber
                                        : Colors.grey,
                                    suffixIcon: registerCubit.obscure2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    suffixFunction: () {
                                      registerCubit.changeObscure2();
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => myButton(
                                text: 'Sign Up',
                                onTap: () {
                                  print(mobilController);
                                  print(set2PasswordController.text);
                                  print(firstNameController);
                                  print(lastNameController);
                                  print(otp);
                                  if (formKey.currentState!.validate()) {
                                    if (set1PasswordController.text ==
                                        set2PasswordController.text) {
                                      registerCubit.registerReWithApi(
                                          mobile: mobilController,
                                          password: set2PasswordController.text,
                                          firstName: firstNameController,
                                          lastName: lastNameController,
                                          otp: otp);
                                    }
                                  }
                                },
                                radius: 30),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
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
