import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {

  Future imageFromGallery(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image as Uint8List?;
  }

  Future imageFromCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    return image as Uint8List?;
  }
}