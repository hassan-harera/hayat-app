import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/presentation/page/donation/book/view_book_donation_item_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/clothing/view_clothing_donation_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/food/view_food_donation_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/medicine/view_medicine_donation_screen.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 155,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 155,
                width: size.width / 3,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(
                      color: Colors.grey.shade50,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    _donationResponse.imageUrl ??
                        'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: size.width / 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 155,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        _donationResponse.title ?? 'Donation',
                        maxLines: 1,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: size.height / 25,
                      ),
                      Text(
                        '${_donationResponse.user!.firstName!} ${_donationResponse.user!.lastName!} ',
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: size.height / 25,
                      ),
                      SizedBox(
                        width: size.height / 25,
                      ),
                      Text(
                        '${_donationResponse.description}',
                        maxLines: 3,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          myEvalutedBottom(
                            borderColor: const Color(0xff20ADDC),
                            color: const Color(0xffCED9E9).withOpacity(.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _donationResponse.communicationMethod == 'PHONE'
                                    ? const Icon(
                                        Icons.phone,
                                        color: Color(0xff20ADDC),
                                      )
                                    : _donationResponse.communicationMethod ==
                                            'CHAT'
                                        ? const Icon(
                                            Icons.chat,
                                            size: 18,
                                            color: Color(0xff20ADDC),
                                          )
                                        : const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.chat,
                                                size: 18,
                                                color: Color(0xff20ADDC),
                                              ),
                                              Icon(
                                                Icons.phone,
                                                color: Color(0xff20ADDC),
                                              ),
                                            ],
                                          ),
                                const SizedBox(width: 4),
                                _donationResponse.telegramLink != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 3.0),
                                        child: Image.asset(
                                          'assets/telegram.png',
                                          scale: 28,
                                          color: Color(0xff20ADDC),
                                        ),
                                      )
                                    : const SizedBox(
                                        width: .1,
                                      ),
                                _donationResponse.whatsappLink != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Image.asset(
                                          'assets/watsAppImage.png',
                                          scale: 28,
                                          color: Color(0xff20ADDC),
                                        ),
                                      )
                                    : const SizedBox(
                                        width: .1,
                                      )
                              ],
                            ),
                            onPressed: () {},
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        '${_donationResponse.city!.englishName}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 18,
                                      color: Color(0xff20ADDC),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      timeAgo(
                                        _donationResponse.donationDate,
                                      ),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.date_range,
                                      size: 18,
                                      color: Color(0xff20ADDC),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
