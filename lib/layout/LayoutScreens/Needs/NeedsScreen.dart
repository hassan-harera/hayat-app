
import 'package:flutter/material.dart';

import '../../../shared/component/component.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/local/Cash_helper/cash_helper.dart';
import '../../Notification/notificationScreen.dart';

class NeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top:10, left: 10,right: 10),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: mySearchTextFormField(
                          borderRadius: 50,
                          prefixIcon: (Icons.search),
                          prefixSize: 30,
                          prefixColor: Color(0xff51565F),
                          hint: 'Search Needs',
                          hintColor: Color(0xff848B94),
                          backGroundColor: Color(0xffCED9E9),
                          borderColor: Color(0xffCED9E9),
                          height: 50
                      )),
                  SizedBox(
                    width: size.width / 40,
                  ),
                  IconButton(
                    onPressed: () {
                      myNavigator(context, notificationScreen());
                    },
                    icon: const Icon(
                      Icons.notifications,
                      size: 33,
                    ),
                    color: Color(0xff20ADDC),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(child: ListView.builder(
                padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding:  EdgeInsets.only(bottom: size.height / 30,),
                    child: itemCategory(context),
                  ), itemCount: 60)),


            ],
          ),
        ),
      ),
    );
  }
}
