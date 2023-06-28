import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/layout/Categories/socialMediaCommunication.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import '../../../../data/model/medicine/medicine_unit.dart';
import '../../../../../services/getRequest/medicine/medicine-search.dart';
import '../../../../data/model/donation/medicine/medicine-api-get.dart';
import '../../../../../shared/Utils/Utils.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constans.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/HayatLaoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';

class MedicineCategoryScreen extends StatefulWidget {
  MedicineCategoryScreen({super.key});

  @override
  State<MedicineCategoryScreen> createState() => _MedicineCategoryScreenState();
}

class _MedicineCategoryScreenState extends State<MedicineCategoryScreen> {
  var searchController = TextEditingController();
  var dateController = TextEditingController();
  var titleController = TextEditingController();
  var DescriptionController = TextEditingController();
  var categoryController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? medicineName;

  var formKey = GlobalKey<FormState>();
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
                    'Medicine Category',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        autovalidateMode: autoValidateMode,
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
                                  child: _file == null
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
                                                          MemoryImage(_file!),
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
                                  hint: 'Title',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please inter title';
                                    }
                                  },
                                )),
                              ],
                            ),
                            myDescriptionTextFormField(
                                controller: DescriptionController),
                            const SizedBox(
                              height: 15,
                            ),
                            myStaticTextFormField(
                              controller: categoryController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please inter title';
                                }
                              },
                              hint: 'medicine Category',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                width: size.width - 237,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller: searchController,
                                                  onFieldSubmitted:
                                                      (value) async {
                                                    medicineName = value;
                                                    SearchMedicineName
                                                        getMedicineName =
                                                        SearchMedicineName();
                                                    getMedicineName
                                                        .getMedicineName(
                                                            medicineName:
                                                                medicineName!);
                                                    print(medicineName);
                                                  },

//
//                                             medicineName=value;
//                                               SearchMedicineName getMedicineName=SearchMedicineName();
//                                              getMedicineName.getMedicineName(medicineName: cityName!);
//                                                 // print(value);
//

                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'this failed is required';
                                                    }
                                                  },

                                                  decoration: InputDecoration(
                                                      hintText: 'hint',
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .amber))),
//                                               );
//                                             child: childmyStaticTextFormField(validator: validator)(
//                                               controller:searchController ,
//
//                                               onSubmitted: (value){
//
//                                             cityName=value;
//                                               SearchMedicineName getMedicineName=SearchMedicineName();
//                                              getMedicineName.getMedicineName(medicineName: cityName!);
//                                                print(value);
//                                               },
//                                               hint: 'food name ',
// onTap: (){}
//                                             ),
                                                ),
                                              )
                                            ]),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: myStaticTextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please inter amount';
                                          }
                                        },
                                        hint: 'Amount',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                        width: 190,
                                        child:
                                            FutureBuilder<List<MedicineUnit>>(
                                          future: MedicineServices()
                                              .getMedicineUnits(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<MedicineUnit> units =
                                                  snapshot.data!;
                                              String? sItem = jsonEncode(
                                                  units[0]
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
                                                items: units
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
                                                                            .amber),
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
                                const SizedBox(
                                  height: 15,
                                ),
                                const SizedBox(
                                  height: 15,
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
                                    // myNavigator(context,

                                    // SocialMediaCommunication(title: titleController.text, quantity: 3, cityId: 1, communicationMethod: layoutCubit.communicationTool.toString(), description: DescriptionController.text, bookTitle: 'bookTitle', foodUnitId: 2, foodCategoryId:3, foodExpirationDate: dateController.text));
                                    formKey.currentState!.save();
                                  } else {
                                    setState(() {});
                                    autoValidateMode = AutovalidateMode.always;
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
