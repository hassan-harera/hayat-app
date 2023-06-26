
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget homeBuilder({
  double imageWidth= double.infinity,
  double imageHeight= 200.0,
  double height= 200.0,
}) => Column(
  children: [
    CarouselSlider(

        items:  [
          CachedNetworkImage(
            fit: BoxFit.contain,
            // matchTextDirection: true,
            width: double.infinity,
            imageUrl:
            "https://altitudehauling.com/wp-content/uploads/2018/10/shutterstock_1022661760-1024x512.jpg",
            placeholder: (context, url) => Center(child: new Icon(
              Icons.favorite_border,
              size: 80,
              color:Color(0xff20Addc),
            ),),
            errorWidget: (context, url, error) => new Icon(
              Icons.favorite,
              size: 80,
              color: Colors.red,
            ),
            imageBuilder: (context, imageProvider) => Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff20Addc), width: 2),

                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
          ),
          // Image(
          //   image: NetworkImage(
          //       'https://altitudehauling.com/wp-content/uploads/2018/10/shutterstock_1022661760-1024x512.jpg'),
          //   width:imageWidth,
          //   height:imageHeight,
          //   fit: BoxFit.cover,
          //
          // ),
          CachedNetworkImage(
            fit: BoxFit.contain,
            // matchTextDirection: true,
            width: double.infinity,
            imageUrl:
            "https://www.goodwillaz.org/wordpress/wp-content/uploads/2018/04/5-15-2.jpg",
            placeholder: (context, url) => new Icon(
              Icons.favorite_border,
              size: 80,
              color: Color(0xff20Addc),
            ),
            errorWidget: (context, url, error) => new Icon(
              Icons.favorite,
              size: 80,
              color: Colors.red,
            ),
            imageBuilder: (context, imageProvider) => Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff20Addc), width: 2),

                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
          ),

          CachedNetworkImage(
            fit: BoxFit.contain,
            // matchTextDirection: true,
            width: double.infinity,
            imageUrl:
            "https://cdn.newsapi.com.au/image/v1/060863537dd81de9b23b76864c2cc715?width=650",
            placeholder: (context, url) => new Icon(
              Icons.favorite_border,
              size: 80,
              color: Color(0xff20Addc),
            ),
            errorWidget: (context, url, error) => new Icon(
              Icons.favorite,
              size: 80,
              color: Colors.red,
            ),
            imageBuilder: (context, imageProvider) => Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff20Addc), width: 2),

                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
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