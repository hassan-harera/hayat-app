import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';

Widget needItem(BuildContext context, NeedResponse needResponse) {
  final size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {},
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
            height: 10.0,
            width: size.width / 20,
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Text(
                    needResponse.title ?? '',
                    maxLines: 1,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
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
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Text(timeAgo(needResponse.needDate!))
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
