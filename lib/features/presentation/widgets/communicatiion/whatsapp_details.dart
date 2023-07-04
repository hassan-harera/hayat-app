import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WhatsappDetails extends StatelessWidget {
  final String? whatsappLink;

  WhatsappDetails({this.whatsappLink});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Whatsapp Link: ',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
        ),
        Expanded(
          child: Linkify(
            maxLines: 1,
            text: whatsappLink ?? 'N/A',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            onOpen: (link) async {
              await launchUrlString(
                whatsappLink ?? '',
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        )
      ],
    );
  }
}
