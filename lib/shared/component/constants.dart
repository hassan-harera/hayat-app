import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigate(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void myNavigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

void myNavigateAndReplacement(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

myButton(
        {double width = double.infinity,
        double height = 50,
        required String text,
        required Function onTap,
        bool isUppercase = true,
        Color color = Colors.amber,
        double fontSize = 18,
        Color textColor = Colors.white,
        double radius = 0}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
              letterSpacing: 3,
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
      ),
    );

Widget defaultTextBottom(
        {required VoidCallback onPressed,
        Color color = Colors.white,
        Color textColor = Colors.black,
        Color borderColor = Colors.amber,
        required String text}) =>
    Container(
      height: 35,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(
          40,
        ),
      ),
      child: myButton(
          text: text,
          onTap: onPressed,
          color: color,
          radius: 40,
          height: 30,
          textColor: textColor,
          isUppercase: false),
    );

Widget myEvalutedBottom(
        {required VoidCallback onPressed,
        Color color = Colors.white,
        Color textColor = Colors.black,
        Color borderColor = Colors.amber,
        required Widget child}) =>
    Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            40,
          ),
        ),
        child: child);

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastState(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { Success, Warning, error }

Color chooseToastState(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.Success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget backIcon(context) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: IconButton(
          style: const ButtonStyle(),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

Widget categoryProvider({
  required String image,
  required String text,
  double imageWidth = 120,
  double imageHeight = 140,
  double width = 140,
  Color? imageColor,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: const Color(0xff20ADDC),
      ),
      child: Column(
        children: [
          Image.asset(image,
              width: imageWidth, height: imageHeight, color: imageColor),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 8),
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );

Widget myCard({
  required IconData? icon,
  required String? text,
  Color? iconColor = Colors.grey,
  Color? textColor = Colors.black,
  required void Function()? onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
          height: 80,
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: MaterialButton(
              height: 80,
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon!,
                    color: iconColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )),
    );

Widget myCard1() => Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(10, 10)),
              ],
            ),
            child: const Card(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HandBag Lv',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          r'$25 ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        PositionedDirectional(
            start: 85,
            bottom: 70,
            child: Image.asset(
              'assets/clothes.png',
              height: 95,
            ))
      ],
    );

class sizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
    print('this is default Size $defaultSize');
  }
}

Widget HayatLogo({
  required String text,
  required String image,
}) =>
    Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(text,
            style: const TextStyle(
                color: Color(0xff20ADDC),
                fontSize: 50,
                letterSpacing: 5,
                fontWeight: FontWeight.bold)),
      ],
    );

class mycustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var w = sizeConfig.screenWidth!;
    var h = sizeConfig.screenHeight!;
    path.moveTo(0, sizeConfig.defaultSize! * 590);
    path.lineTo(0, h);
// // path.quadraticBezierTo(0, h, 50,h);
    path.lineTo(w, h);
// //  path.quadraticBezierTo(0, h, 50,h);
    path.lineTo(w, sizeConfig.defaultSize! * 47);
    path.quadraticBezierTo(sizeConfig.defaultSize! * 25,
        sizeConfig.defaultSize! * 57, 0, sizeConfig.defaultSize! * 59);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

SnackBar mySnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}

Widget defaultTextFormField({
  TextEditingController? controller,
  TextInputType? keyboardType = TextInputType.text,
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
      padding: const EdgeInsetsDirectional.only(bottom: 10),
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
          hintText: hint,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
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

class ItemBuilder extends StatelessWidget {
  ItemBuilder(
      {super.key,
      required this.categoryName,
      required this.file,
      required this.description,
      required this.date});

  final String? categoryName;
  late final Uint8List? file;
  final String? description;
  final String? date;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 155,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 155,
              width: size.width / 3,
              decoration: BoxDecoration(
                  color: const Color(0xffE3EAF2),
                  border: Border.all(
                    color: const Color(0xffE3EAF2),
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: file == null
                  ? Image.asset(
                      'assets/add-image.png',
                      width: 100,
                      height: 100,
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
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: MemoryImage(file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter,
                                )),
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              width: size.width / 20,
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      categoryName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      width: size.height / 25,
                    ),
                    const Text(
                      'Mohamed Ahmed',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: size.height / 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '$description ',
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE3EAF2),
                            border: Border.all(color: const Color(0xff20ADDC)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: size.height / 20,
                          width: size.width / 3,
                        ),
                        const Spacer(),
                        Text('$date'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
