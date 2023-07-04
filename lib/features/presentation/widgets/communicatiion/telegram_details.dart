import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TelegramDetails extends StatelessWidget {
  final String? telegramLink;

  TelegramDetails({this.telegramLink});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Telegram Link: ',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
        ),
        Expanded(
          child: Linkify(
            maxLines: 1,
            text: telegramLink ?? 'N/A',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            onOpen: (link) async {
              await launchUrlString(
                telegramLink ?? '',
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ),
      ],
    );
  }
}
