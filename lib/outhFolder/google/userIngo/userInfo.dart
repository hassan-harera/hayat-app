import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat-egLayout.dart';
import 'package:hayat_eg/modules/StartApp/login/Login.dart';
import 'package:hayat_eg/shared/component/constans.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/Utils/Utils.dart';
import '../outh.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;

  bool _isSigningOut = false;
  Uint8List? myFile;

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
      pageBuilder: (context, animation, secondaryAnimation) =>
           LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
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
    _user = widget._user;
    print(_user.getIdToken()) ;
    print('#############################################################################################') ;
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
                const SizedBox(
                  height: 100,
                ),
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
                                      padding: const EdgeInsets.all(10),
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.amber,
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
                                      padding: const EdgeInsets.all(10),
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
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hello ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      '${_user.displayName!}',
                      style: const TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'You are now signed in using your Google account',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, letterSpacing: 0.2),
                ),
                const SizedBox(height: 5.0),
                Text(
                  ' ( ${_user.email}) .',
                  style: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 16,
                      letterSpacing: 0.2),
                ),
                const SizedBox(height: 24.0),
                Text(
                  textAlign: TextAlign.center,
                  'You are now signed in using your Google account. To Start Using the App Press "Start" button below.',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 14,
                      letterSpacing: 0.2),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
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
                    setState(() {
                      _isSigningOut = true;
                    });
                    await AuthenticationTest.signOut(context: context);
                    setState(() {
                      _isSigningOut = false;
                    });
                   myNavigator(context, _routeToSignInScreen());
                  },
                  child: const Padding(
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
    );
  }
}
