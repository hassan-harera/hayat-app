import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/outhFolder/google/userIngo/userInfo.dart';
import 'package:hayat_eg/shared/component/constans.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'outh.dart';

// class GoogleSignInButton extends StatefulWidget {
//   @override
//   _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
// }
//
// class _GoogleSignInButtonState extends State<GoogleSignInButton> {
//   bool _isSigningIn = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn
//           ? const CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
//       )
//           : OutlinedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.white),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//         ),
//           onPressed: () async {
//             setState(() {
//               _isSigningIn = true;
//             });
//
//             User? user =
//             await AuthenticationTest.signInWithGoogle(context: context);
//
//
//             setState(() {
//               _isSigningIn = false;
//             });
//
//             if (user != null) {
//
//             }
//           },
//         child: const Padding(
//           padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//           child: SizedBox(
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Image(
//                   image: AssetImage("assets/google.png"),
//                   height: 30.0,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 5),
//                     child: Text(
//                       'Google Sign in ',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  double progressNum=0;
  int progressNumber() {
    var random = Random();
    var randomNumber = random.nextInt(100);
    print(randomNumber);
    return randomNumber ;

  }

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ?   Padding(
        padding:  EdgeInsetsDirectional.only(start: size.width/8,end: size.width/8 ),
        child: CircularPercentIndicator(
          animation: true,
          animationDuration: 1000,
          radius: 25,
          backgroundColor: Colors.amber.shade200,
          percent: .99,
          circularStrokeCap: CircularStrokeCap.round,
          center:  Text('${progressNumber()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber),),


          progressColor: Colors.amber,
          lineWidth: 5,

        ),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
        setState(() {
          _isSigningIn = true;
        });

        User? user =
        await AuthenticationTest.signInWithGoogle(context: context);

        setState(() {
          _isSigningIn = false;
        });

        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => UserInfoScreen(
                user: user,
              ),
            ),
          );
        }
      },
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/google.png"),
                  height: 30.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Google Sign in ',
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
    );
  }
}
