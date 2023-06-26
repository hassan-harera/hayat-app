import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/modules/StartApp/registerScreen/Register/register.dart';
import 'package:hayat_eg/outhFolder/facebook/method.dart';
import '../../../layout/HayatLayout/hayat-egLayout.dart';
import '../../../outhFolder/google/GoogleSignInButton.dart';
import '../../../outhFolder/google/outh.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constans.dart';
import '../registerScreen/forgetPasswordFolder/forgetPassword/ForgetPassword.dart';
import 'LoginCubit/LoginCubit.dart';
import 'LoginCubit/LoginStates.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  var subjectController = TextEditingController();
  var passwordController = TextEditingController();
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  String ?deviceToken;
  @override
  void initState() {
    // TODO: implement initState
    fcm.getToken().then((token) {
      deviceToken=token;
      print('the token is :$token');
    });
  }
  @override
  Widget build(BuildContext context) {
   final size =MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            myNavigateAndFinish(context,const HayatLayoutScreen());
          }else if (state is LoginErrorState){
            showDialog(context: context, builder: (context) => AlertDialog(
             content: Text(state.error,style: const TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return AbsorbPointer(
            absorbing: state is LoginLoadingState?true:false,
            child: GestureDetector(
              onTap: (){
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
                                width: size.width/2,
                                height: size.height/5,
                                decoration: const BoxDecoration(


                                    image:DecorationImage(
                                      image:AssetImage('assets/slider.png',),
                                    ),

                                ),
                              ),
                            ],

                            ),
                            Text(
                              "login".toUpperCase(),
                              style:const TextStyle(
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
                      child: ListView(
                        children:[
                          Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                             const   SizedBox(
                                  height:45,
                                ),
                                Form(
                                  key: formKey,
                                  autovalidateMode: autoValidateMode,
                                  child: Column(
                                    children: [
                                      myTextFormField(
                                        label: ('Email Address'),
                                        prefixIcon: (Icons.email_outlined),
                                        controller: subjectController,
                                        hint: 'Example@gmail.com',
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value){

                                          if(value!.isEmpty){
                                            return " Email Address is Required";
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                      ),
                                        const SizedBox(
                                        height: 15,
                                      ),
                                      myTextFormField(

                                        label: 'Password',
                                        hint: '. . . . . . . . . . .',
                                        prefixIcon: Icons.lock_outline,
                                        keyboardType: TextInputType.visiblePassword,
                                        controller: passwordController,
                                        suffixIcon:
                                        loginCubit.obscure   ? Icons.visibility_off : Icons.visibility,
                                        suffixColor: loginCubit.obscure ? Colors.grey : Colors.amber,
                                        obscure: loginCubit.obscure,
                                        suffixFunction: () {

                                         loginCubit.changeObscure();
                                        },
                                        validator: (value) {
                                          if(value!.isEmpty){
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
                                                myNavigator(
                                                    context, forgetPasswordScreen());
                                              }),
                                        ],
                                      ),

                                      ConditionalBuilder(
                                        condition: state is! LoginLoadingState,
                                        builder: (context) => myButton(
                                            text: 'login',
                                            onTap: () {
                                              if (formKey.currentState!.validate()) {

                                               loginCubit.loginWithApi(subject: subjectController.text, password: passwordController.text,deviceToken: deviceToken);
                                               formKey.currentState!.save();
                                              }else{
                                                autoValidateMode=AutovalidateMode.always;
                                              }
                                            },
                                            radius: 30),
                                        fallback: (context) =>
                                            const Center(child: CircularProgressIndicator()),
                                      ),
                              const  SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          //new one
                                          Expanded(
                                            child: FutureBuilder(
                                              future: AuthenticationTest.initializeFirebase(context: context),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return const Text('Error initializing Firebase');
                                                } else if (snapshot.connectionState == ConnectionState.done) {
                                                  return GoogleSignInButton();
                                                }
                                                return const CircularProgressIndicator(
                                                  color: Colors.orange,

                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: size.width/80,),
                                          Expanded(
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                                shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(40),
                                                  ),
                                                ),
                                              ),
                                              onPressed: ()  {},
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Image(
                                                        image: AssetImage("assets/facebook.png"),
                                                        height: 30.0,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 5),
                                                          child: Text(
                                                            'facebook sign in',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.black54,

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
                                    const Text('Don\'t have an account?'),
                                    defaultTextBottom(
                                        function: () {
                                          myNavigator(context, RegisterScreen());
                                        },

                                        text: 'Sign up'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
