import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/presentation/page/signup/phoneNumber/PhoneNumberCubit.dart';
import 'package:hayat_eg/features/presentation/page/signup/phoneNumber/PhoneNumberStates.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:hayat_eg/shared/component/constants.dart';

import '../phoneVerification/phoneVervicationScreen.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen(
      {super.key, required this.firstNameController, required this.lastNameController});

  var formKey = GlobalKey<FormState>();
  final String firstNameController;
  final String lastNameController;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PhoneNumberCubit(),
      child: BlocConsumer<PhoneNumberCubit, PhoneNumberStates>(
        listener: (context, state) {
          if (state is PhoneNumberSuccessState) {
            navigate(
                context,
                PhoneVerificationScreen(
                  mobilController: phoneController.text,
                  lastNameController: lastNameController,
                  firstNameController: firstNameController,
                ));
            showDialog(context: context, builder: (context) => const AlertDialog(
              content: Text('Success',style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.green,
            ));
          }
          else if (state is PhoneNumberErrorState){
            showDialog(context: context, builder: (context) => AlertDialog(
              content: Text(state.errorMessage,style: const TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          PhoneNumberCubit phoneNumberCubit = PhoneNumberCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: backIcon(context),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 2,
                        height: size.height / 5,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
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
                    'Sign Up'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.amber,
                        ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Form(
                    key: formKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        myStaticTextFormField(
                          hint: 'Please Inter You Phone Number',
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icons.phone_outlined,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Number is Required';
                            } else if (value.length < 11) {
                              return 'Phone Number Is TooShort';
                            } else if (value.length > 11) {
                              return 'Phone Number Is Too long';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is PhoneNumberLoadingState,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          fallback: (context) => myButton(
                              radius: 30,
                              text: 'Next',
                              onTap: () {
                                onSubmitted(phoneNumberCubit);
                              }),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
  void onSubmitted(PhoneNumberCubit phoneNumberCubit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      phoneNumberCubit.phoneVerificationInRegister(
          mobile: phoneController.text
      );
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
