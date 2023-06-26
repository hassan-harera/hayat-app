import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../on_bording/onBordingLayout.dart';
class splashBody extends StatefulWidget {
  @override
  State<splashBody> createState() => _splashBodyState();
}

class _splashBodyState extends State<splashBody> with SingleTickerProviderStateMixin{
  AnimationController ?animationController;
  Animation<double> ?fadingAnimation;
  @override
  void initState() {
    super.initState();
    animationController=AnimationController(vsync: this,duration:const Duration(seconds: 1));
    fadingAnimation =Tween<double>(begin: 0.2 ,end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
    goToNextPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
               const Spacer(),
              Center(child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                   Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.amber

                      ),
                      shape: BoxShape.circle,
                      image:DecorationImage(
                        image:AssetImage('assets/logo5.jpg'),
                      ),
                      color: Colors.transparent
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                FadeTransition(
                  opacity: fadingAnimation!,
                  child: const Text('Hayat',style: TextStyle(

                      color: Color(0xff20ADDC),
                      fontSize: 50,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold
                  )),
                ),
                ],)),
          const Spacer(),


        ],
      ),
    );
  }


void goToNextPage() {
  Future.delayed(const Duration(seconds: 3),
      (){
   Get.to(()=> OnBoardingScreen()

   );
      });
}
}