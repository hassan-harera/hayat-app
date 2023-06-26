import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat-egLayout.dart';
import 'package:hayat_eg/outhFolder/google/outh.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/StartApp/login/Login.dart';
import '../../../shared/Utils/Utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User _user;
  bool _isSigningOut = false;
  Uint8List? myFile;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;

  _selectImage(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create post '),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  const Text(
                    'Take a photo from camera',
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  myFile = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.image),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  const Text('chose from gallery '),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  myFile = file;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    // _user = widget._user;
    // // emailController.text = _user.email!;
    // nameController.text = _user.displayName!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff293242),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _user.photoURL != null
                      ? GestureDetector(
                          onTap: () => _selectImage(context),
                          child: myFile == null
                              ? ClipOval(
                                  child: Material(
                                    color: Colors.grey.withOpacity(0.3),
                                    child: Image.network(
                                      _user.photoURL!,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: AspectRatio(
                                      aspectRatio: 478 / 451,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: MemoryImage(myFile!),
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      : GestureDetector(
                          onTap: () => _selectImage(context),
                          child: myFile == null
                              ? ClipOval(
                                  child: Material(
                                    color: Colors.grey.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: AspectRatio(
                                      aspectRatio: 478 / 451,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: MemoryImage(myFile!),
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                  SizedBox(height: 16.0),
                  Form(
                    key: formKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('Change Email',textAlign: TextAlign.start,style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        myStaticTextFormField(
                          filled: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Please inter your name';
                            }
                          },
                          hint: 'Inter Your Name',
                          controller: nameController,
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  _isSigningOut
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if(formKey.currentState!.validate()) {
                              setState(() {
                                _isSigningOut = true;
                              });
                              await AuthenticationTest.signOut(
                                  context: context);
                              setState(() {
                                _isSigningOut = false;
                              });
                              Navigator.of(context)
                                  .pushReplacement(_routeToSignInScreen());

                            }else{
                              autoValidateMode=AutovalidateMode.always;
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
