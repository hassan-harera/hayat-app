import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/datasource/donation/food/food_donation_datasource.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_request.dart';
import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/features/data/repository/donation/food_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/food/food_repository.dart';
import 'package:hayat_eg/features/presentation/page/communication_method.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/styles/styles.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../data/model/donation/medicine/createMedicineDonation.dart';
import '../../../../../shared/Utils/Utils.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';

class CreateFoodDonationScreen extends StatefulWidget {
  @override
  State<CreateFoodDonationScreen> createState() =>
      _CreateFoodDonationScreenState();
}

class _CreateFoodDonationScreenState extends State<CreateFoodDonationScreen> {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  var titleController = TextEditingController();
  int? categoryId;
  int? unitId;

  var descriptionController = TextEditingController();
  var categoryController = TextEditingController();
  var quantityController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var communicationMethod = TextEditingController();

  FoodDonationRepository _foodDonationRepository = sl();
  FoodRepository _foodRepository = sl();
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
                    'Food Donation',
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
                                  future: _foodRepository.listCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<FoodCategory> data = snapshot.data!;
                                      return DropdownButtonFormField(
                                        hint: const Text('Unit'),
                                        iconEnabledColor: Colors.amber,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        items: data
                                            .map((item) => DropdownMenuItem(
                                                value: item.englishName,
                                                child: Text(item.englishName
                                                    as String)))
                                            .toList(),
                                        onChanged: (item) {
                                          sItem = item;
                                          unitId = data[0].id;
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
                                          'City',
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
                                                return 'City Required';
                                              }
                                            },
                                            hint: 'Location City ',
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
                                        controller: quantityController,
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
                                          future: _foodRepository.listUnits(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<FoodUnit> data =
                                                  snapshot.data!;
                                              sItem = data[0].englishName;
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
                                                            value: item
                                                                .englishName,
                                                            child: Text(
                                                                item.englishName
                                                                    as String)))
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
                                      layoutCubit.communicationTool = 'CHAT';
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
                                      layoutCubit.communicationTool = 'PHONE';
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
                                    value: 'Phone & chat',
                                    groupValue: layoutCubit.communicationTool,
                                    onChanged: (value) {
                                      layoutCubit.communicationTool =
                                          'CHAT_AND_PHONE';
                                      layoutCubit.changRadioValue();
                                      //   setState(() {});
                                    }),
                                const Text(
                                  'Phone & chat',
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
                                  onSubmit(layoutCubit);
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

  void onSubmit(LayoutCubit layoutCubit) {
    final request = FoodDonationRequest(
      title: titleController.text,
      description: descriptionController.text,
      cityId: 1,
      communicationMethod: layoutCubit.communicationTool,
      quantity: double.parse(quantityController.text),
      foodCategoryId: categoryId,
      foodUnitId: 1,
    );

    final response = _foodDonationRepository.create(request);
    response.onError((error, stackTrace) {});

    response.then((value) => {}, onError: (error, stackTrace) {
      error as BadRequestException;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Something Went Wrong'),
            content: Text(error.apiError.displayMessage.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('Dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      stackTrace.printError();
    });
  }
}
