import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/datasource/donation/food/food-api-get.dart';
import 'package:hayat_eg/features/data/model/food/foodCategory.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/layout/Categories/socialMediaCommunication.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../data/model/donation/medicine/createMedicineDonation.dart';
import '../../../../../shared/Utils/Utils.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';

class FoodCategoryScreen extends StatefulWidget {
  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  var titleController = TextEditingController();
  int? categoryId;
  var descriptionController = TextEditingController();

  var categoryController = TextEditingController();

  var quantityController = TextEditingController();

  var dateController = TextEditingController();

  var timeController = TextEditingController();

  String? sItem;
  Uint8List? myFile;

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
                  myFile = file;
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
                  myFile = file;
                });
              },
            ),
          ],
        );
      },
    );
  }

  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  String? deviceToken;

  @override
  void initState() {
    // TODO: implement initState
    fcm.getToken().then((token) {
      deviceToken = token;
      print('the token is :$token');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Food Category',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        autovalidateMode: autoValidateMode,
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => _selectImage(context),
                                  child: myFile == null
                                      ? Image.asset(
                                          'assets/add-image.png',
                                          width: 100,
                                          height: 100,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: AspectRatio(
                                              aspectRatio: 478 / 451,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image:
                                                          MemoryImage(myFile!),
                                                      fit: BoxFit.fill,
                                                      alignment:
                                                          FractionalOffset
                                                              .topCenter,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                // const Spacer(),
                                Expanded(
                                    child: myStaticTextFormField(
                                  controller: titleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please inter title';
                                    }
                                  },
                                  hint: 'Title',
                                )),
                              ],
                            ),
                            myDescriptionTextFormField(
                                controller: descriptionController),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<FoodCategory>>(
                                  future: FoodServices().getFoodCategory(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<FoodCategory> data = snapshot.data!;
                                      sItem = jsonEncode(
                                          data[0].englishName.toString());
                                      return DropdownButtonFormField(
                                        hint: const Text('Unit'),
                                        iconEnabledColor: Colors.amber,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: sItem.toString(),
                                        items: data
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(item
                                                    .englishName
                                                    .toString()),
                                                child: Text(
                                                  jsonEncode(item.englishName
                                                      .toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          sItem = item;

                                          categoryId = data[0].id;
                                        },
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            constraints: const BoxConstraints(
                                                maxHeight: 60),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.amber),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Search',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          width: size.width - 230,
                                          child: myStaticTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please inter title';
                                              }
                                            },
                                            hint: 'food name ',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Expiration Date',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                            width: 190,
                                            child: ExprirationDate(
                                              controller: dateController,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: myStaticTextFormField(
                                        keyboardType: TextInputType.number,
                                        hint: 'Amount',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please inter title';
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                        width: 190,
                                        child: FutureBuilder<List<FoodUnit>>(
                                          future: FoodServices().getFoodUnits(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<FoodUnit> data =
                                                  snapshot.data!;
                                              sItem = jsonEncode(data[0]
                                                  .englishName
                                                  .toString());
                                              return DropdownButtonFormField(
                                                hint: const Text('Unit'),
                                                iconEnabledColor: Colors.amber,
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 30,
                                                ),
                                                value: sItem.toString(),
                                                items: data
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                            value: jsonEncode(
                                                                item.englishName
                                                                    .toString()),
                                                            child: Text(
                                                              jsonEncode(item
                                                                  .englishName
                                                                  .toString()),
                                                            )))
                                                    .toList(),
                                                onChanged: (item) {
                                                  sItem = item;
                                                },
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    focusColor: Colors.amber,
                                                    filled: true,
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 60),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.amber),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        Colors
                                                                            .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                              );
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Communication Method',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 'Chat',
                                    groupValue: layoutCubit.communicationTool,
                                    onChanged: (value) {
                                      layoutCubit.communicationTool = value;
                                      layoutCubit.changRadioValue();
                                      //   setState(() {});
                                    }),
                                const Text(
                                  'chat',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 'Phone',
                                    groupValue: layoutCubit.communicationTool,
                                    onChanged: (value) {
                                      layoutCubit.communicationTool = value;
                                      layoutCubit.changRadioValue();
                                      //  setState(() {});
                                    }),
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 'Phone-chat',
                                    groupValue: layoutCubit.communicationTool,
                                    onChanged: (value) {
                                      layoutCubit.communicationTool = value;
                                      layoutCubit.changRadioValue();
                                      //   setState(() {});
                                    }),
                                const Text(
                                  'Phone-chat',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myButton(
                                text: 'Next',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    CreateMedicineDonation()
                                        .postMedicineDonation(
                                            communication_method: layoutCubit
                                                .communicationTool
                                                .toString(),
                                            quantity: quantityController.text,
                                            city_id: 'city_id',
                                            description:
                                                descriptionController.text,
                                            state: 'state',
                                            title: titleController.text,
                                            medicine_unit_id: sItem.toString(),
                                            medicine_id: 'medicine_id',
                                            medicine_expiration_date:
                                                dateController.text,
                                            token: 'deviceToken');
                                    myNavigator(
                                        context,
                                        SocialMediaCommunication(
                                            file: myFile,
                                            date: dateController.text,
                                            categoryName:
                                                layoutCubit.titleList[2],
                                            title: titleController.text,
                                            quantity: 1,
                                            cityId: 1,
                                            communicationMethod: layoutCubit
                                                .communicationTool
                                                .toString(),
                                            description:
                                                descriptionController.text,
                                            bookTitle: 'bookTitle',
                                            foodUnitId: 2,
                                            foodCategoryId: categoryId,
                                            foodExpirationDate:
                                                dateController.text));
                                    formKey.currentState!.save();
                                  } else {
                                    setState(() {
                                      autoValidateMode =
                                          AutovalidateMode.always;
                                    });
                                  }
                                  //
                                },
                                radius: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
