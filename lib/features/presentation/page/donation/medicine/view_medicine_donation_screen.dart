import 'package:flutter/material.dart';
import 'package:hayat_eg/features/presentation/page/notification/notificationScreen.dart';
import 'package:hayat_eg/features/presentation/widgets/search_widget.dart';
import 'package:hayat_eg/shared/component/component.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class BookDonationScreen extends StatefulWidget {
  BookDonationScreen(
      {@required this.donationList, @required this.donationBuilder});

  List<ItemBuilder>? donationList = [];
  ItemBuilder? donationBuilder;

  @override
  State<BookDonationScreen> createState() => _BookDonationScreenState();
}

class _BookDonationScreenState extends State<BookDonationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: HayatSearchTextFormField(
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
                    color: Color(0xff20ADDC),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
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
