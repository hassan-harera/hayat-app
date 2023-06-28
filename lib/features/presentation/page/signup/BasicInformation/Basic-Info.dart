import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/shared/component/constants.dart';

import '../../../../shared/component/constants.dart';
import '../../login/Login.dart';
import '../RegisterCubit/registerState.dart';
import '../RegisterCubit/rigistrCubit.dart';

class basicInformationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  bool obsecure = false;

  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();
  var emaileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          RegisterCubit registertCubit = RegisterCubit.get(context);
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
                        'Basic Information ',
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
                        'Please Enter your data',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(220, 233, 240, 0),
                                  )
                                ],
                              ),
                              child: TextFormField(
                                obscureText: obsecure,
                                controller: firstNameController,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    // LoginCubit.get(context).userLogin(email: emailController.text, password: PasswordController.text);
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter Code';
                                  }
                                },
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline),
                                    hintText: 'First Name',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(220, 233, 240, 0),
                                  )
                                ],
                              ),
                              child: TextFormField(
                                obscureText: obsecure,
                                controller: lastNameController,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    // LoginCubit.get(context).userLogin(email: emailController.text, password: PasswordController.text);
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter Your Last Name';
                                  }
                                },
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline),
                                    hintText: 'Last Name',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Email Address',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(220, 233, 240, 0),
                                  )
                                ],
                              ),
                              child: TextFormField(
                                controller: emaileController,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    // LoginCubit.get(context).userLogin(email: emailController.text, password: PasswordController.text);
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter Your Phone';
                                  }
                                },
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: 'Example@gmail.com',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: registertCubit.checked,
                                    onChanged: (value) {
                                      registertCubit.changeCheckbox(value);
                                    }),
                                const Text('I agree To The Privacy Policy')
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => myButton(
                            text: 'Verifiay',
                            onTap: () {
                              if ((formKey.currentState!.validate())) {
                                if ((registertCubit.checked == true)) {
                                  myNavigator(context, LoginScreen());
                                }

                                //
                                // LoginCubit.get(context).userLogin(
                                //     email: emailController.text,
                                //     password: PasswordController.text);
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
