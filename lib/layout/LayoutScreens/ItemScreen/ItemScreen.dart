import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({super.key, required this.titleName});

  String? titleName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) =>
                AlertDialog(
                  content: BarcodeWidget(
                    data: titleName!,
                    barcode: Barcode.qrCode(),
                    color: Colors.black,
                    width: 250,
                    height: 250,),
                  backgroundColor: Colors.grey[50],
                ));
          }, icon: const Icon(Icons.qr_code, color: Colors.black,)),
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
                  height: size.height / 4,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO( 4, 108, 109, 1),
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
}
