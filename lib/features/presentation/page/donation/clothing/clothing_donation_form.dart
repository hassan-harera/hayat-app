import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';
import 'package:hayat_eg/features/data/repository/clothing/clothing_repository.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat_layout.dart';
import 'package:hayat_eg/shared/Utils/Utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';

class ClothesCategoryScreen extends StatefulWidget {
  @override
  State<ClothesCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<ClothesCategoryScreen> {
  Uint8List? _file;
  var telegramController = TextEditingController();
  var watsAppController = TextEditingController();
  String? sItem;

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

  final formKey = GlobalKey<FormState>();
  var descriptionController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  ClothingRepository clothingRepository = sl();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          final size = MediaQuery.of(context).size;
          // final User user =Provider.of<UserProvider>(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Transform(
                    transform:
                        Matrix4.translationValues(size.width - 250, 0.0, 0.0),
                    child: const Text(
                      'Clothes Category',
                    ),
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
                                myStaticTextFormField(
                                  width: size.width - 160,
                                  hint: 'Title',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please add Title';
                                    }
                                  },
                                ),
                              ],
                            ),
                            myDescriptionTextFormField(
                                controller: descriptionController),
                            const SizedBox(
                              height: 15,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                isFilterOnline: true,
                                fit: FlexFit.loose,
                                showSelectedItems: true,
                                showSearchBox: true,
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                favoriteItemProps: FavoriteItemProps(
                                  showFavoriteItems: true,
                                ),
                              ),
                              items: const [
                                'bani-suif',
                                'mansura',
                                'cairo',
                                'tanta',
                                'alexandria',
                                'bani-suif',
                                'mansura',
                                'cairo',
                                'tanta',
                                'alexandria',
                              ],
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  border: OutlineInputBorder(
                                    gapPadding: 10,
                                  ),
                                  hintText: "Please Chose Your Country",
                                ),
                              ),
                              onChanged: print,
                              selectedItem: null,
                              validator: (String? item) {
                                if (item == null) {
                                  return "City Name is  Required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothingCategory>>(
                                  future: clothingRepository
                                      .listClothingCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothingCategory> units =
                                          snapshot.data!;
                                      sItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Clothes Type'),
                                        iconEnabledColor: Colors.amber,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: sItem,
                                        items: units
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(item
                                                    .englishName
                                                    .toString()),
                                                child: Text(
                                                  (item.englishName.toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          sItem = item;
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
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothingType>>(
                                  future:
                                      clothingRepository.listClothingTypes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothingType> units = snapshot.data!;
                                      sItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Clothes Gender'),
                                        iconEnabledColor: Colors.amber,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: sItem,
                                        items: units
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(item
                                                    .englishName
                                                    .toString()),
                                                child: Text(
                                                  (item.englishName.toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          sItem = item;
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
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: myStaticTextFormField(
                                    keyboardType: TextInputType.number,
                                    hint: 'Quantity',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please inter Amount';
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: FutureBuilder<List<ClothingSize>>(
                                      future: clothingRepository
                                          .listClothingSizes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<ClothingSize> units =
                                              snapshot.data!;
                                          sItem = null;
                                          return DropdownButtonFormField(
                                            hint: const Text('Clothes Size'),
                                            iconEnabledColor: Colors.amber,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 30,
                                            ),
                                            value: sItem,
                                            items: units
                                                .map((item) => DropdownMenuItem(
                                                    value: jsonEncode(item
                                                        .englishName
                                                        .toString()),
                                                    child: Text(
                                                      (item.englishName
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
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.amber),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
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
                            const Text(
                              'Social Media',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 10,
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
                                  'Communication Method',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.amber,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.amber,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myButton(
                                text: 'Submit',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    myNavigator(
                                        context, const HayatLayoutScreen());
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
