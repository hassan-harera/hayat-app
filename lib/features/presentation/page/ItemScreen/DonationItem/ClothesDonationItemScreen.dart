import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class ClothesDonationItemScreen extends StatefulWidget {
  const ClothesDonationItemScreen({super.key});

  @override
  State<ClothesDonationItemScreen> createState() =>
      _ClothesDonationItemScreenState();
}

class _ClothesDonationItemScreenState extends State<ClothesDonationItemScreen> {
  int ratingNumber = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: BarcodeWidget(
                            data: 'data for make QR ',
                            barcode: Barcode.qrCode(),
                            color: Colors.black,
                            width: 250,
                            height: 250,
                          ),
                          backgroundColor: Colors.grey[50],
                        ));
              },
              icon: const Icon(
                Icons.qr_code,
                color: Colors.black,
              )),
        ],
        title: const Text('Clothes Donation'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          top: size.height / 45,
        ),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height / 3.8,
                    width: size.width / 1.3,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(4, 108, 109, 1),
                        border: Border.all(
                          color: const Color(0xffE3EAF2),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                ratingNumber++;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.black,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$ratingNumber',
                          maxLines: 1,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                ratingNumber--;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 45,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 3,
                                  'Clothes Title  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '12 May',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(Icons.date_range),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 3,
                                  'Mohamed ahmed',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Bani-Suef',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Icon(Icons.location_on_outlined),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: ListView(shrinkWrap: true, children: const [
                        Text(
                          'Description ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donation Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Type : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'shorts',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Gender : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Men',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Quantity : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  '2 pieces}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Size : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Small',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Condition : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'good',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Season : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Summer',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Social Media',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Communication Method : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Chat ',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'watsapp Number : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  '01288166326 ',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Telegram : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'https://t.me/ }',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
