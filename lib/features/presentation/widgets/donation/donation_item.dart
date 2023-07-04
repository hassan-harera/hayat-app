import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/presentation/page/donation/book/view_book_donation_item_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/clothing/ClothesDonationItemScreen.dart';
import 'package:hayat_eg/features/presentation/page/donation/food/view_food_donation_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/medicine/view_medicine_donation_screen.dart';
import 'package:hayat_eg/features/presentation/widgets/images/downloaded_image_utils.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class DonationItem extends StatelessWidget {
  final DonationResponse _donationResponse;

  const DonationItem(donationResponse, {super.key})
      : _donationResponse = donationResponse;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        viewDonationItemScreen(context, _donationResponse);
      },
      child: SizedBox(
        height: size.height / 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: DownloadedImage(
                  imageUrl: _donationResponse.imageUrl ?? '',
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      _donationResponse.title ?? '',
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      width: size.height / 25,
                    ),
                    Text(
                      '${_donationResponse.user!.firstName!} ${_donationResponse.user!.lastName!}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: size.height / 25,
                    ),
                    const Text(
                      '',
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        Text(timeAgo(_donationResponse.donationDate)),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  )),
                              SizedBox(width: 4),
                              Text(
                                'مكالمة',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  )),
                              SizedBox(width: 4),
                              Text(
                                'مكالمة',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void viewDonationItemScreen(
      BuildContext context, DonationResponse donationResponse) {
    if (_donationResponse.category == 'BOOKS') {
      navigate(context, BookDonationDetailsScreen(id: donationResponse.id!));
    } else if (_donationResponse.category == 'MEDICINE') {
      navigate(context, MedicineDonationItemScreen(id: donationResponse.id!));
    } else if (_donationResponse.category == 'FOOD') {
      navigate(context, FoodDonationItemScreen(id: donationResponse.id!));
    } else if (_donationResponse.category == 'CLOTHING') {
      navigate(context, ClothesDonationItemScreen(id: donationResponse.id!));
    }
  }
}
