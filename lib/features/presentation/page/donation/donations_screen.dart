import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/repository/donation/donation_repository.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/shared/component/component.dart';

import '../../../../shared/component/constants.dart';
import '../notification/notificationScreen.dart';

class DonationsScreen extends StatefulWidget {
  DonationsScreen(
      {@required this.donationList, @required this.donationBuilder});

  List<ItemBuilder>? donationList = [];
  ItemBuilder? donationBuilder;

  DonationRepository donationRepository = sl();
  List<DonationResponse> _donations = [];

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                    prefixColor: const Color(0xff51565F),
                    hint: 'Search Donation',
                    hintColor: const Color(0xff848B94),
                    backGroundColor: const Color(0xffCED9E9),
                    borderColor: const Color(0xffCED9E9),
                    height: 50,
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
                    color: const Color(0xff20ADDC),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height / 30,
                            ),
                            child: widget.donationList?[index],
                          ),
                      itemCount: widget.donationList?.length ?? 0)),
            ],
          ),
        ),
      ),
    );
  }
}
