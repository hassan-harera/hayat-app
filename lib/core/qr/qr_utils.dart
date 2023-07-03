import 'package:qr_flutter/qr_flutter.dart';

Future<QrImageView> generateQrCode(String qrData) async {
  return QrImageView(
    data: qrData,
    version: QrVersions.auto,
    size: 200.0,
  );
}
