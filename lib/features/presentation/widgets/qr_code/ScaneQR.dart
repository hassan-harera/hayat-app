import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class GenerateQRCode extends StatefulWidget {
  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  var qrstr = 'add data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BarcodeWidget(
            data: qrstr,
            barcode: Barcode.qrCode(),
            color: Colors.amber,
            width: 250,
            height: 250,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  qrstr = value;
                });
              },
              decoration: const InputDecoration(
                  hintText: 'enter your data here ',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2))),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}
