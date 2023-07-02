import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/repository/donation/book_donation_repository.dart';
import 'package:hayat_eg/injection_container.dart';

class BookDonationScreen extends StatefulWidget {
  final int _id;

  const BookDonationScreen(this._id, {super.key});

  @override
  State<BookDonationScreen> createState() =>
      _BookDonationScreen(_id);
}

class _BookDonationScreen extends State<BookDonationScreen> {
  final BookDonationRepository _bookDonationRepository = sl();
  final int _id;
  late BookDonationResponse _bookDonationResponse;
  String titleName = 'Book Donation';

  _BookDonationScreen(this._id);

  @override
  void initState() {
    super.initState();
    _bookDonationRepository.get(_id).then((value) {
      setState(() {
        _bookDonationResponse = value as BookDonationResponse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showQr(context);
              },
              icon: const Icon(
                Icons.qr_code,
                color: Colors.black,
              )),
        ],
        title: Text('$titleName'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 3.5,
                  width: size.width / 1.2,
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Text(
                  'Title : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text('        '),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Publisher : ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text('        '),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'publish Date : ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text('         '),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Description : ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text('        '),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Medicine Category : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('        '),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Amount : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('        '),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Need Data : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('         '),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Need Expiration Date : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('        '),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showQr(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: BarcodeWidget(
              data: _bookDonationResponse.qrCode as String,
              barcode: Barcode.qrCode(),
              color: Colors.black,
              width: 250,
              height: 250,
            ),
            backgroundColor: Colors.grey[50],
          );
        });
  }
}
