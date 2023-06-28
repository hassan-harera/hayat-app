import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/presentation/page/signup/forgetPasswordFolder/ForgetPasswordCubit/ForgetPasswordCubit.dart';
import 'package:hayat_eg/features/presentation/page/signup/forgetPasswordFolder/ForgetPasswordCubit/forgetPasswordState.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:hayat_eg/shared/component/constants.dart';
import '../RestPassword/RestPassword.dart';

class IdentityVerificationScreen extends StatefulWidget {
  IdentityVerificationScreen({required this.phoneNumber});

  late final String phoneNumber;

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  var formKey = GlobalKey<FormState>();

  var verificationController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   verificationController.text='000000';
  // }
  // @override
  // void dispose() {
  //   verificationController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is OtpVerificationSuccessState) {
            myNavigator(
                context,
                resetPasswordScreen(
                  phoneNum: widget.phoneNumber,
                  otp: verificationController.text,
                ));
          } else if (state is OtpVerificationErrorState) {
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
          return GestureDetector(
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
                          'Identity Verification ',
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
                          child: Column(
                            children: [
                              myStaticTextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty || value.length != 6) {
                                    return ' Please Enter Code';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                hint: '***-***',
                                controller: verificationController,
                                prefixIcon: Icons.phone,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ConditionalBuilder(
                          condition: state is! OtpVerificationLoadingState,
                          builder: (context) => myButton(
                              text: 'Verify',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  forgetPasswordCubit.oTPVerificationRegister(
                                      mobile: widget.phoneNumber,
                                      otp: verificationController.text);
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
            ),
          );
        },
      ),
    );
  }
}
