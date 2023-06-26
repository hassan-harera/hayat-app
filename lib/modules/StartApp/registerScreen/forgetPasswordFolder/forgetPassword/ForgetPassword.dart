import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/shared/component/component.dart';
import '../../../../../shared/component/constans.dart';


import '../ForgetPasswordCubit/ForgetPasswordCubit.dart';
import '../ForgetPasswordCubit/forgetPasswordState.dart';
import '../IdentityVerification/IdentityVerification.dart';


class forgetPasswordScreen extends StatefulWidget {
  const forgetPasswordScreen({super.key});


  @override
  State<forgetPasswordScreen> createState() => _forgetPasswordScreenState();
}

class _forgetPasswordScreenState extends State<forgetPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if(state is SetPhoneSuccessState){
            myNavigateAndFinish(context, IdentityVerificationScreen( phoneNumber: phoneController.text,));
          }
          // else if (state is SetPhoneErrorState){
          //   showDialog(context: context, builder: (context) => AlertDialog(
          //     content: Text(state.errorMessage,style: const TextStyle(color: Colors.white),),
          //     backgroundColor: Colors.red,
          //   ));
          // }
        },
        builder: (context, state) {
          ForgetPasswordCubit forgetPasswordCubit =ForgetPasswordCubit.get(context);
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
                                    padding:
                                        const EdgeInsetsDirectional.only(start: 35),
                                    child: Image.asset(
                                      'assets/lock.png',
                                      scale: 1.7,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        bottom: 10, top: 10),
                                    child: Icon(
                                      Icons.question_mark,
                                      size: 80,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Forget Password',
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
                          'Please Enter your Number To Send You The Confirmation Code',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Phone Number',
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
                                validator: (value) {
                                  if (value!.length>11){
                                    return 'your password is  long';
                                  }
                                 else if (value.isEmpty || value.length != 11) {
                                    return ' your password is too short';
                                  }
                                },
                                controller: phoneController,
                                hint: '01xx-xxx-xxxx',
                                keyboardType: TextInputType.number,
                                prefixIcon: Icons.phone,

                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ConditionalBuilder(
                                condition: true,
                                builder: (context) => myButton(
                                    text: 'Next',
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {

                                        forgetPasswordCubit.sendMobileNumber(mobile: phoneController.text);
                                        formKey.currentState!.save();
                                      } else {
                                        setState(() {

                                        });

                                        autoValidateMode =
                                            AutovalidateMode.always;
                                      }
                                    },
                                    radius: 30),
                                fallback: (context) =>
                                    const Center(child: CircularProgressIndicator()),
                              ),
                            ],
                          ),
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
