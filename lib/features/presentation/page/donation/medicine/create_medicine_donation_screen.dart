import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine-search.dart';
import 'package:hayat_eg/features/presentation/page/communication_method.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../../../shared/Utils/Utils.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';
import '../../../../data/model/donation/medicine/medicine-api-get.dart';
import '../../../../data/model/medicine/medicine_unit.dart';

class MedicineCategoryScreen extends StatefulWidget {
  const MedicineCategoryScreen({super.key});

  @override
  State<MedicineCategoryScreen> createState() => _MedicineCategoryScreenState();
}

class _MedicineCategoryScreenState extends State<MedicineCategoryScreen> {
  var medicineSearchController = TextEditingController();
  var medicineDateController = TextEditingController();
  var medicineTitleController = TextEditingController();
  var medicineDescriptionController = TextEditingController();
  var medicineNameController = TextEditingController();
  var telegramController = TextEditingController();
  var watsAppController = TextEditingController();
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
                                                padding:
                                                    const EdgeInsets.all(10),
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
                                      controller: medicineTitleController,
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
                                controller: medicineDescriptionController),
                            const SizedBox(
                              height: 15,
                            ),
                            myStaticTextFormField(
                              controller: medicineNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please inter title';
                                }
                              },
                              hint: 'medicine ',
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
                                                'City',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black45),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: size.width - 237,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller:
                                                      medicineSearchController,
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
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'this failed is required';
                                                    }
                                                  },

                                                  decoration: InputDecoration(
                                                      hintText: 'Search city',
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
                                                ),
                                              )
                                            ]),
                                      ],
                                    ),
                                    const Spacer(),
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
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black45),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                                width: 190,
                                                child: ExprirationDate(
                                                  hint: 'Please Inter Date',
                                                  controller:
                                                      medicineDateController,
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Medicine Amount',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black45),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          myStaticTextFormField(
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please inter amount';
                                              }
                                            },
                                            hint: 'Amount',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                        width: 190,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Medicine Unit',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black45),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
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
                                                    iconEnabledColor:
                                                        Colors.amber,
                                                    icon: const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 30,
                                                    ),
                                                    value: sItem.toString(),
                                                    items: units
                                                        .map((item) =>
                                                            DropdownMenuItem(
                                                                value: jsonEncode(item
                                                                    .englishName
                                                                    .toString()),
                                                                child: Text(
                                                                  (item
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
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .amber),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
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
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Communication Method',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: RadioListTile(
                                        value: 'Chat',
                                        selectedTileColor: Colors.white,
                                        title: const Text(
                                          'Chat',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        groupValue:
                                            layoutCubit.communicationTool,
                                        onChanged: (value) {
                                          layoutCubit.communicationTool = value;
                                          layoutCubit.changRadioValue();
                                        }),
                                  ),
                                  GestureDetector(
                                    child: RadioListTile(
                                        value: 'Phone',
                                        activeColor: Colors.amber,
                                        hoverColor: Colors.amber,
                                        selectedTileColor: Colors.white,
                                        selected: true,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: const Text(
                                          'Phone',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        groupValue:
                                            layoutCubit.communicationTool,
                                        onChanged: (value) {
                                          layoutCubit.communicationTool = value;
                                          layoutCubit.changRadioValue();
                                        }),
                                  ),
                                  GestureDetector(
                                    excludeFromSemantics: true,
                                    child: RadioListTile(
                                        value: 'Phone & Chat',
                                        activeColor: Colors.amber,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        hoverColor: Colors.amber,
                                        title: const Text(
                                          'Phone & Chat',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        groupValue:
                                            layoutCubit.communicationTool,
                                        onChanged: (value) {
                                          layoutCubit.communicationTool = value;
                                          layoutCubit.changRadioValue();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Social Media',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: watsAppController,
                                  keyboardType: TextInputType.phone,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'please add your watsApp number';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Image.asset(
                                        'assets/watsAppImage.png',
                                        scale: 18,
                                        color: Colors.amber,
                                      ),
                                      hintText: 'WatsApp',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.amber,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.amber))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'please add your telegram number';
                                    }
                                  },
                                  controller: telegramController,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.telegram_outlined,
                                        color: Colors.amber,
                                        size: 35,
                                      ),
                                      hintText: 'Telegram',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.amber,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.amber))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myButton(
                                text: 'Submit',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    myNavigator(
                                        context,
                                        SocialMediaCommunication(
                                          title: medicineTitleController.text,
                                          quantity: 3,
                                          cityId: 1,
                                          communicationMethod: layoutCubit
                                              .communicationTool
                                              .toString(),
                                          description:
                                              medicineDescriptionController
                                                  .text,
                                          bookTitle: 'bookTitle',
                                          foodUnitId: 2,
                                          foodCategoryId: 3,
                                          foodExpirationDate:
                                              medicineDateController.text,
                                          file: null,
                                        ));
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
