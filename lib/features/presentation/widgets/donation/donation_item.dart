import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/model/donation/donation_category.dart';
import 'package:hayat_eg/features/presentation/page/ItemScreen/DonationItem/BookDonationItemScreen.dart';
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
          height: size.height / 5.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height / 5.5,
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
                  height: size.height / 5.5,
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
                      Text(
                        '${_donationResponse.city!.englishName}',
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: 26,
                                    height: 26,
                                    child:
                                        _donationResponse.communicationMethod ==
                                                'Phone'
                                            ? const Icon(
                                                Icons.phone,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.chat,
                                                color: Colors.black,
                                              )),
                                const SizedBox(width: 4),
                                Text(
                                  _donationResponse.communicationMethod ==
                                          'Phone'
                                      ? 'Phone'
                                      : 'Chat',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          const Spacer(),
                          Text(
                            timeAgo(
                              _donationResponse.donationDate,
                            ),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
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
      myNavigator(context, const BookDonationItemScreen());
    } else if (_donationResponse.category == DonationCategory.MEDICINE) {
    } else if (_donationResponse.category == 'FOOD') {}
    else if (_donationResponse.category == 'MEDICINE') {}
    else if (_donationResponse.category == 'OTHER') {}
  }
}
