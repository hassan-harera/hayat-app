import 'package:flutter/material.dart';
import 'package:hayat_eg/shared/component/component.dart';
import '../../../shared/component/constans.dart';
import '../../Notification/notificationScreen.dart';
class DonationScreen extends StatefulWidget {
  DonationScreen({ @required this.donationList,@required this.donationBuilder});
   List<itemBuilder>? donationList=[];
    itemBuilder? donationBuilder;

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 10,right: 10),
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
                          hint: 'Search Donation',
                          hintColor: Color(0xff848B94),
                          backGroundColor: Color(0xffCED9E9),
                          borderColor: Color(0xffCED9E9),
                          height: 50,


                      )
                  ),
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
                    child: widget.donationList?[index],
                  ), itemCount: widget.donationList?.length??0)),


            ],
          ),
        ),
      ),
    );
  }
}
