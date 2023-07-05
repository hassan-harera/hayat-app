import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/presentation/page/need/book/book_need_details_screen.dart';
import 'package:hayat_eg/features/presentation/page/need/medicine/MedicineNeedItemScreen.dart';
import 'package:hayat_eg/features/presentation/page/need/blood/blood_need_screen.dart';
import 'package:hayat_eg/shared/component/constants.dart';

Widget needItem(BuildContext context, NeedResponse needResponse) {
  print(needResponse.category);
  final size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      navigateToNeedDetails(context, needResponse);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  color: const Color(0xffE3EAF2),
                  border: Border.all(
                    color: const Color(0xffE3EAF2),
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Icons.image_outlined,
                color: Colors.black,
                size: 40,
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
                      needResponse.title ?? '',
                      maxLines: 1,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: size.height / 25,
                    ),
                    Text(
                      '${needResponse.user!.firstName!} ${needResponse.user!.lastName!}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: size.height / 25,
                    ),
                    const Text(
                      'Description food  food Donation Description food  food Donation Description food  food Donation',
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
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
                        Text(
                          '${DateTime.now().subtract(Duration(milliseconds: DateTime.parse(needResponse.needDate!).millisecond)).minute} min ago',
                          style: TextStyle(fontSize: 12),
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

void navigateToNeedDetails(BuildContext context, NeedResponse needResponse) {
  print(needResponse.category);
  if (needResponse.category == 'BLOOD') {
    navigate(context, BloodNeedDetailsScreen());
  } else if (needResponse.category == 'BOOKS') {
    navigate(context, BookNeedDetailsScreen());
  } else if (needResponse.category == 'MEDICINE') {
    navigate(context, MedicineNeedItemScreen());
  }
}
