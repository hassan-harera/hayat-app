import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget homeBuilder({
  double imageWidth = double.infinity,
  double imageHeight = 200.0,
  double height = 200.0,
}) =>
    Column(
      children: [
        CarouselSlider(
            items: [
              Image.asset(
                'assets/poor.jpg',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/medicine_donation.jpg',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/clothing_donation.jpg',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/food_donation.jpg',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ],
            options: CarouselOptions(
                autoPlay: true,
                height: height,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1))
      ],
    );
