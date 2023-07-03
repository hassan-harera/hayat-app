import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BookDonationItemScreen extends StatefulWidget {
  @override
  State<BookDonationItemScreen> createState() => _BookDonationItemScreenState();
}

class _BookDonationItemScreenState extends State<BookDonationItemScreen> {
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
        title: const Text('Book Donation'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          top: size.height / 45,
        ),
        child: ListView(children: [
          Column(
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
                            icon: const Icon(Icons.arrow_upward)),
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
                            icon: const Icon(Icons.arrow_downward))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 45,
              ),
              const Row(
                children: [
                  Text(
                    'Book Title : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'title Data     ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Existing City : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'Bani-Suif',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Book Sub Title : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'title Data     ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Book Publisher : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'Publisher Data ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'publishing Date : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'publish Data',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Book Description : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'Description Data ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Book Quantity : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      '5 books ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Book Language : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'arabic ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Social Media',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Communication Method : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'Chat ',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'watsapp Number : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      '01288226326 ',
                      maxLines: 2,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Telegram : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: Text(
                      'https://t.me/ }',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
