import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/repository/donation/donation_repository.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  final DonationRepository _donationsRepository = sl<DonationRepository>();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQRView(context),
            Positioned(bottom: 90, child: buildResult()),
            Positioned(top: 10, child: setting()),
            Positioned(bottom: 10, child: buildControllerButton()),
          ],
        ),
      ),
    );
  }

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.amber,
            borderWidth: 8,
            borderRadius: 10,
            borderLength: 20,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) {
      controller.pauseCamera();
      _submit(barcode.code!);
    });
  }

  buildResult() => Container(
        width: 300,
        padding: const EdgeInsets.only(
          top: 16,
          left: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white54.withOpacity(.1),
        ),
        child: const Center(
          child: SelectableText(
            'Scan qr code ',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        ),
      );

  Widget buildControllerButton() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white54.withOpacity(.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  await controller?.pauseCamera();
                },
                child: const Text('pause',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  await controller?.resumeCamera();
                },
                child: const Text('resume',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )
          ],
        ),
      );

  Widget setting() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white54.withOpacity(.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(
                      CupertinoIcons.switch_camera_solid,
                      color: Colors.white,
                    );
                  } else {
                    return const Text('loading');
                  }
                },
              ),
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            )
          ],
        ),
      );

  void _submit(String code) async {
    print(code);
    var scanDonation = _donationsRepository.scanDonation(code);
    // scanDonation.then((value) {
    //   if (value) {
    //     Navigator.pop(context);
    //   }
    // });

    scanDonation.then((value) {
      print(value);
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تسجيل الاستلام بنجاح'),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ ما'),
          ),
        );
      }
    });
  }
}
