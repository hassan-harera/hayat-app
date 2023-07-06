import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_category.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_condition.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_seasson.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_size.dart';
import 'package:hayat_eg/features/data/model/clothing/clothing_type.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_request.dart';
import 'package:hayat_eg/features/data/repository/CityRepository.dart';
import 'package:hayat_eg/features/data/repository/clothing/clothing_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/clothing/clothing_donation_repository.dart';
import 'package:hayat_eg/features/presentation/page/donation/clothing/view_clothing_donation_screen.dart';
import 'package:hayat_eg/features/presentation/widgets/dialog/success_dialog.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/shared/Utils/Utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';

class CreateClothingDonationScreen extends StatefulWidget {
  const CreateClothingDonationScreen({super.key});

  @override
  State<CreateClothingDonationScreen> createState() =>
      _CreateClothingDonationScreen();
}

class _CreateClothingDonationScreen
    extends State<CreateClothingDonationScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var clothingType = TextEditingController();
  var clothingSeason = TextEditingController();
  var clothingSize = TextEditingController();
  var clothingCategory = TextEditingController();
  var clothingCondition = TextEditingController();
  final _quantityController = TextEditingController();
  var communicationMethod = TextEditingController();
  var telegramController = TextEditingController();
  var whatsappController = TextEditingController();
  String? selectedTypeItem;
  String? sGenderItem;
  String? sSizeItem;
  CityRepository _cityRepository = sl();
  ClothingRepository _clothingRepository = sl();
  ClothingDonationRepository _clothingDonationRepository = sl();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  Uint8List? _file;
  String? sItem;
  late int cityId;
  List<City>? _cities = [];
  List<ClothingCategory> _clothingCategories = [];
  List<ClothingSeason> _clothingSeasons = [];
  List<ClothingCondition> _clothingConditions = [];
  List<ClothingType> _clothingTypes = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cityRepository.search('').then((value) {
      setState(() {
        _cities = value;
      });
    });

    _clothingRepository.listClothingCategories().then((value) {
      setState(() {
        _clothingCategories = value;
      });
    });

    _clothingRepository.listClothingSeason().then((value) {
      setState(() {
        _clothingSeasons = value;
      });
    });

    _clothingRepository.listClothingCondition().then((value) {
      setState(() {
        _clothingConditions = value;
      });
    });

    _clothingRepository.listClothingTypes().then((value) {
      setState(() {
        _clothingTypes = value;
      });
    });
  }

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
                                Expanded(
                                  child: requiredTextField(
                                    hint: 'Title',
                                    controller: titleController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please add Title';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            descriptionTextField(
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
                              items: _cities!.map((e) => e.arabicName).toList(),
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
                                  hintText: "Select city",
                                ),
                              ),
                              onChanged: (value) => setState(() {
                                cityId = _cities!
                                    .firstWhere((element) =>
                                        element.arabicName == value)
                                    .id;
                              }),
                              selectedItem: null,
                              validator: (String? item) {
                                if (item == null) {
                                  return "City is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothingCategory>>(
                                  future: _clothingRepository
                                      .listClothingCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothingCategory> units =
                                          snapshot.data!;
                                      selectedTypeItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Clothes Type'),
                                        iconEnabledColor: Colors.amber,
                                        iconDisabledColor: const Color.fromARGB(
                                            143, 144, 144, 144),
                                        focusColor: Colors.red,
                                        enableFeedback: true,
                                        validator: (selectedTypeItem) {
                                          if (selectedTypeItem == null) {
                                            return 'please Add Clothes Type';
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: selectedTypeItem,
                                        items: units
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(
                                                    item.arabicName.toString()),
                                                child: Text(
                                                  (item.arabicName.toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          clothingCategory.text = snapshot.data!
                                              .firstWhere((element) =>
                                                  jsonEncode(element.arabicName
                                                      .toString()) ==
                                                  item)
                                              .id
                                              .toString();
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.amber),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.amber),
                                          ),
                                        ),
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
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothingCondition>>(
                                  future: _clothingRepository
                                      .listClothingCondition(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothingCondition> units =
                                          snapshot.data!;
                                      selectedTypeItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Clothes Condition'),
                                        iconEnabledColor: Colors.amber,
                                        iconDisabledColor: const Color.fromARGB(
                                            143, 144, 144, 144),
                                        focusColor: Colors.red,
                                        enableFeedback: true,
                                        validator: (selectedTypeItem) {
                                          if (selectedTypeItem == null) {
                                            return 'please Add Clothes Type';
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: selectedTypeItem,
                                        items: units
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(
                                                    item.arabicName.toString()),
                                                child: Text(
                                                  (item.arabicName.toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          clothingCondition.text = snapshot
                                              .data!
                                              .firstWhere((element) =>
                                                  jsonEncode(element.arabicName
                                                      .toString()) ==
                                                  item)
                                              .id
                                              .toString();
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.amber),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.amber),
                                          ),
                                        ),
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
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothingSeason>>(
                                  future:
                                      _clothingRepository.listClothingSeason(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothingSeason> units =
                                          snapshot.data!;
                                      selectedTypeItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Clothes Season'),
                                        iconEnabledColor: Colors.amber,
                                        iconDisabledColor: const Color.fromARGB(
                                            143, 144, 144, 144),
                                        focusColor: Colors.red,
                                        enableFeedback: true,
                                        validator: (selectedTypeItem) {
                                          if (selectedTypeItem == null) {
                                            return 'please Add Clothes Type';
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: selectedTypeItem,
                                        items: units
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(
                                                    item.arabicName.toString()),
                                                child: Text(
                                                  (item.arabicName.toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          clothingSeason.text = snapshot.data!
                                              .firstWhere((element) =>
                                                  jsonEncode(element.arabicName
                                                      .toString()) ==
                                                  item)
                                              .id
                                              .toString();
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.amber),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.amber),
                                          ),
                                        ),
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
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothingType>>(
                                  future:
                                      _clothingRepository.listClothingTypes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothingType> units = snapshot.data!;
                                      sGenderItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Clothes Gender'),
                                        iconEnabledColor: Colors.amber,
                                        validator: (sGenderItem) {
                                          if (sGenderItem == null) {
                                            return 'please Add Clothes Gender';
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: sGenderItem,
                                        items: units
                                            .map((item) => DropdownMenuItem(
                                                value: jsonEncode(
                                                    item.arabicName.toString()),
                                                child: Text(
                                                  (item.arabicName.toString()),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          clothingType.text = units
                                              .firstWhere((element) =>
                                                  element.arabicName ==
                                                  jsonDecode(item as String))
                                              .id
                                              .toString();
                                        },
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
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
                                  child: requiredTextField(
                                    controller: _quantityController,
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
                                      future: _clothingRepository
                                          .listClothingSizes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<ClothingSize> units =
                                              snapshot.data!;
                                          sSizeItem = null;
                                          return DropdownButtonFormField(
                                            hint: const Text('Clothes Size'),
                                            iconEnabledColor: Colors.amber,
                                            validator: (sSizeItem) {
                                              if (sSizeItem == null) {
                                                return 'please Add Clothes Size';
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 30,
                                            ),
                                            value: sSizeItem,
                                            items: units
                                                .map((item) => DropdownMenuItem(
                                                    value: jsonEncode(item
                                                        .arabicName
                                                        .toString()),
                                                    child: Text(
                                                      (item.arabicName
                                                          .toString()),
                                                    )))
                                                .toList(),
                                            onChanged: (item) {
                                              sSizeItem = item;
                                            },
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
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
                                          communicationMethod.text = 'CHAT';
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
                                          communicationMethod.text = 'PHONE';
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
                                          communicationMethod.text =
                                              'CHAT_AND_PHONE';
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
                                  controller: whatsappController,
                                  keyboardType: TextInputType.phone,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'please add your watsApp number';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Image.asset(
                                      'assets/watsAppImage.png',
                                      scale: 25,
                                    ),
                                    hintText: 'Whatsapp',
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
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
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
                                    prefixIcon: Image.asset(
                                      'assets/telegram.png',
                                      scale: 28,
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
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
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
                                    _onSubmit();
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

  void _onSubmit() async {
    final request = ClothingDonationRequest(
      title: titleController.text,
      description: descriptionController.text,
      clothingCategoryId: int.tryParse(clothingCategory.text, radix: null),
      clothingConditionId: int.tryParse(clothingCondition.text, radix: null),
      clothingSeasonId: int.tryParse(clothingSeason.text, radix: null),
      clothingTypeId: int.tryParse(clothingType.text, radix: null),
      quantity: int.parse(_quantityController.text, radix: null),
      communicationMethod: communicationMethod.text,
      telegramLink: 'https://t.me/${telegramController.text}',
      whatsappLink: 'https://wa.me/+2${whatsappController.text}',
      cityId: cityId,
    );

    final response = _clothingDonationRepository.create(request);
    response.then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: 'Your Donation Request has been sent successfully',
            );
          });
      uploadImage(value?.id as int);
    });
    response.onError((error, stackTrace) {
      if (error is BadRequestException) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Something Went Wrong'),
              content: Text(error.apiError.displayMessage.toString()),
              actions: <Widget>[
                TextButton(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      stackTrace.printError();
    });
  }

  uploadImage(int id) {
    if (_file != null) {
      _clothingDonationRepository
          .updateImage(id, _file as Uint8List)
          .then((value) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const SuccessDialog(
                      message:
                          'Your Donation Request has been sent successfully',
                    );
                  }),
                )
              });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ClothesDonationItemScreen(id: id);
        }),
      );
    }
  }
}
