import 'package:flutter/material.dart';

class DownloadedImage extends StatelessWidget {
  final imageUrl;

  const DownloadedImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ??
          'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg',
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image,
          color: Colors.blue,
          size: 100,
        );
      },
    );
  }
}