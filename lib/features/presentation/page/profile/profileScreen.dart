import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/features/presentation/page/Needs/ask_blood_need_screen.dart';
import 'package:hayat_eg/features/presentation/page/Needs/ask_book_need_screen.dart';
import 'package:hayat_eg/features/presentation/page/Needs/ask_medicine_need_screen.dart';
import 'package:hayat_eg/features/presentation/page/notification/notificationScreen.dart';
import 'package:hayat_eg/shared/Utils/Utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/component/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create post '),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  const Text(
                    'Take a photo from camera',
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.image),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  const Text('chose from gallery '),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.amber,
                ))
          ],
        ),
        body: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _selectImage(context),
                      child: _file == null
                          ? CachedNetworkImage(
                              fit: BoxFit.contain,
                              height: 100,
                              width: 100,
                              imageUrl:
                                  "https://findepartament.com/static/transit/t118/img/text-photo-1.png",
                              placeholder: (context, url) => const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.amber,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 80,
                                color: Colors.red,
                              ),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      width: 160.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.orange, width: 2),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover))),
                            )
                          : SizedBox(
                              height: 100,
                              width: 100,
                              child: AspectRatio(
                                aspectRatio: 478 / 451,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.amber, width: 2),
                                      image: DecorationImage(
                                        image: MemoryImage(_file!),
                                        fit: BoxFit.fill,
                                        alignment: FractionalOffset.center,
                                      )),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mohamed Ahmed ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '01288226326 ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    myCard(
                        onPressed: () {
                          myNavigator(context, const AakBookNeedScreen());
                        },
                        icon: Icons.book,
                        text: 'Create Book Need'),
                    myCard(
                        onPressed: () {
                          myNavigator(context, AskBloodNeedScreen());
                        },
                        icon: Icons.bloodtype,
                        text: 'Create Blood Need'),
                    myCard(
                        onPressed: () {
                          myNavigator(context, const AskMedicineNeedScreen());
                        },
                        icon: Icons.medical_information,
                        text: 'Create Medicine Need'),
                    myCard(
                        onPressed: () {
                          print('object');
                        },
                        icon: Icons.share,
                        text: 'Share'),
                    myCard(
                        onPressed: () {
                          myNavigator(context, notificationScreen());
                        },
                        icon: Icons.notifications,
                        text: 'Notifications'),
                    myCard(
                        onPressed: () {
                          print('object');
                        },
                        icon: Icons.logout,
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        text: 'Sign Out'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
