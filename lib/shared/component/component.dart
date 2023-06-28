import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

Widget mySearchTextFormField(
        {TextEditingController? controller,
        double borderRadius = 10,
        TextInputType? keyboardType = TextInputType.text,
        String? hint,
        bool obscure = false,
        bool filledStatus = true,
        Function? suffixFunction,
        IconData? prefixIcon,
        IconData? suffixIcon,
        Color? labelColor,
        Color? prefixColor,
        Color? suffixColor,
        Color? hintColor,
        Color? backGroundColor,
        Color? borderColor,
        double? height,
        double? prefixSize,
        void Function(String)? onChanged}) =>
    TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'this failed is required';
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: prefixColor,
            size: prefixSize,
          ),
          constraints: BoxConstraints(maxHeight: height!),
          hintText: hint!,
          hintStyle: TextStyle(color: hintColor),
          filled: filledStatus,
          fillColor: backGroundColor!,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor!,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor))),
    );

Widget myDefaultTextFormField({
  TextEditingController? controller,
  double borderRadius = 10,
  TextInputType? keyboardType = TextInputType.text,
  String? hint,
  bool obscure = false,
  bool filledStatus = true,
  required String? Function(String?)? validator,
  Function? suffixFunction,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Color? labelColor,
  Color? prefixColor,
  Color? suffixColor,
  Color? hintColor,
  Color? backGroundColor,
  Color? borderColor,
  double? height,
}) =>
    TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: prefixColor,
          ),
          constraints: BoxConstraints(minHeight: height!),
          hintText: hint!,
          hintStyle: TextStyle(color: hintColor),
          filled: filledStatus,
          fillColor: backGroundColor!,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor!,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor))),
    );

Widget mySpecialTextFormField({
  TextEditingController? controller,
  double borderRadius = 10,
  TextInputType? keyboardType = TextInputType.text,
  String? hint,
  bool? obscure = false,
  bool? filledStatus = true,
  Function? suffixFunction,
  Function? onTap,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Color? labelColor,
  Color? prefixColor,
  Color? suffixColor,
  Color? hintColor,
  Color? backGroundColor,
  Color? borderColor,
  double? height,
}) =>
    TextFormField(
      keyboardType: keyboardType,
      controller: controller!,
      onTap: () {
        onTap!();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'this failed is required';
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: prefixColor,
          ),
          constraints: BoxConstraints(minHeight: height!),
          hintText: hint!,
          hintStyle: TextStyle(color: hintColor),
          filled: filledStatus,
          fillColor: backGroundColor!,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor!,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor))),
    );

Widget myDescriptionTextFormField(
        {required TextEditingController? controller}) =>
    TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Description is required';
        }
      },
      maxLines: 7,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.amber,
        )),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Description',
        hintStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );

Widget myTextFormField({
  TextEditingController? controller,
  TextInputType? keyboardType = TextInputType.text,
  required String? label,
  String? hint,
  bool obscure = false,
  Function? onsubmitted,
  Function? suffixFunction,
  required String? Function(String?)? validator,
  Function? data,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Color? labelColor,
  Color? prefixColor,
  Color? suffixColor,
}) =>
    Padding(
      padding: EdgeInsetsDirectional.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(),
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscure,
        onFieldSubmitted: (value) {
          onsubmitted!();
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(
            prefixIcon,
            color: prefixColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixFunction!();
                  },
                  icon: Icon(
                    suffixIcon,
                    color: suffixColor,
                  ))
              : null,
          label: Text(
            label!,
            style: TextStyle(color: labelColor, fontWeight: FontWeight.w600),
          ),
          hintText: hint,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.01),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;
    var path = Path();
    path.lineTo(0, h / 1.25);
    path.cubicTo(w / 2 * 0.6, h * 0.6, w, h * 1.4, w * 1.2, h / 1.5);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Widget donateCategoryItem({
  required String image,
  required String text,
  double imageWidth = 130,
  double imageHeight = 130,
  double width = 140,
  Color color = Colors.cyanAccent,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.blue,
      ),
      child: Column(
        children: [
          Image.asset(image,
              width: imageWidth, height: imageHeight, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 8),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );

// class Authentication {
//   static SnackBar mySnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }
//
//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     final GoogleSignInAccount? googleSignInAccount =
//     await googleSignIn.signIn();
//
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       try {
//         final UserCredential userCredential =
//         await auth.signInWithCredential(credential);
//
//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.mySnackBar(
//               content: 'The account already exists with a different credential',
//             ),
//           );
//         } else if (e.code == 'invalid-credential') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.mySnackBar(
//               content: 'Error occurred while accessing credentials. Try again.',
//             ),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           Authentication.mySnackBar(
//             content: 'Error occurred using Google Sign In. Try again.',
//           ),
//         );
//       }
//     }
//
//     return user;
//   }
//
//   static Future<void> signOut({required BuildContext context}) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     try {
//       if (!kIsWeb) {
//         await googleSignIn.signOut();
//       }
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.mySnackBar(
//           content: 'Error signing out. Try again.',
//         ),
//       );
//     }
//   }
//
//   // static Future<void> signOut({required BuildContext context}) async {
//   //   final GoogleSignIn googleSignIn = GoogleSignIn();
//   //
//   //   try {
//   //     if (!kIsWeb) {
//   //       await googleSignIn.signOut();
//   //     }
//   //     await FirebaseAuth.instance.signOut();
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       Authentication.mySnackBar(
//   //         content: 'Error signing out. Try again.',
//   //       ),
//   //     );
//   //   }
//   // }
//   static Future<FirebaseApp> initializeFirebase({
//     required BuildContext context,
//   }) async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//
//     User? user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => UserInfoScreen(
//             user: user,
//           ),
//         ),
//       );
//     }
//
//     return firebaseApp;
//   }
// }

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<bool> sininWithGoogle(BuildContext context) async {
    bool isSignin = false;
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (kDebugMode) {
          print('user $user');
        }
        if (user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            await _firestore.collection('users').doc(user.uid).set({
              'name': user.displayName,
              'profilePhoto': user.photoURL,
              'uid': user.uid,
            });
          }
          isSignin = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      isSignin = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
    return isSignin;
  }
}

int titleIndex = 0;

Widget myStaticTextFormField(
        {TextEditingController? controller,
        TextInputType? keyboardType = TextInputType.text,
        String? hint,
        bool obscure = false,
        bool filled = true,
        void Function(String)? onFieldSubmitted,
        Function? suffixFunction,
        required String? Function(String?)? validator,
        Function? data,
        IconData? prefixIcon,
        IconData? suffixIcon,
        Color? labelColor,
        Color? prefixColor,
        Color? suffixColor,
        double? width = double.infinity,
        void Function()? onTap}) =>
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: width,
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        style: const TextStyle(),
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscure,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: prefixColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixFunction!();
                  },
                  icon: Icon(
                    suffixIcon,
                    color: suffixColor,
                  ))
              : null,
          hintText: hint,
          fillColor: Colors.white,
          filled: filled,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

class ExprirationDate extends StatelessWidget {
  ExprirationDate({required this.controller});

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.parse('2400-05-07'))
              .then((value) {
            controller.text = DateFormat.yMMMd().format(value!);
          });
        },
        decoration: InputDecoration(
          hintText: 'Epiration Date',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.amber,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
