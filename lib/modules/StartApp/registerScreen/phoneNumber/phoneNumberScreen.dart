
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/modules/StartApp/login/Login.dart';


import '../../../../shared/component/component.dart';
import '../../../../shared/component/constans.dart';
import '../RegisterCubit/registerState.dart';
import '../RegisterCubit/rigistrCubit.dart';
import '../phoneVerification/phoneVervicationScreen.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({required this.firstNameController,required this.lastNameController});
var formKey =  GlobalKey<FormState>();
final String firstNameController;
final String lastNameController;
AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context, state) {
          if(state is PhoneVerificationRegisterSuccessState){
            myNavigateAndFinish(context, PhoneVerificationScreen(mobilController: phoneController.text,lastNameController: lastNameController,firstNameController: firstNameController,));

          }
          // else if (state is SetPhoneErrorState){
          //   showDialog(context: context, builder: (context) => AlertDialog(
          //     content: Text(state.errorMessage,style: const TextStyle(color: Colors.white),),
          //     backgroundColor: Colors.red,
          //   ));
          // }
        },
        builder: (context, state) {
          RegisterCubit registerCubit =  RegisterCubit.get(context);
          return  Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: backIcon(context),
            ),
            body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
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
                                const Text('Phone Number',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),
                              const  SizedBox(height: 10,),
                              myTextFormField(
                                  label: 'Please Inter Your Phone Number',
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                prefixIcon: Icons.phone_outlined,
                                validator: (value){
                                    if(value! .isEmpty){
                                      return 'Phone Number is Required';
                                    }

                                },

                              ),

                       const   SizedBox(
                            height: 20,
                          ),


                                ConditionalBuilder(
                                  condition: true,
                                  builder: (context) =>   myButton(
                                      radius: 30,
                                      text: 'Next',
                                      onTap: (){

                                        if(formKey.currentState!.validate()){


                                          registerCubit.phoneVerification(mobile: phoneController.text);
                                          formKey.currentState!.save();
                                        }else{

                                          autoValidateMode=AutovalidateMode.always;
                                        }
                                      }
                                  ) ,
                                  fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                                ),

                                const   SizedBox(
                            height: 20,
                          ),

                      const    SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already hava an account?'),
                              defaultTextBottom(function: (){


                              myNavigator(context, LoginScreen());

                              }, text: 'LOGIN ')
                            ],
                          ),


                        ],
                      ),

          ),
                ]  ),
            ),
          ),
                ),




          );
        },

      ),
    );
  }
}