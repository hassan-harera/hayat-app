import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/food/food_donation_request.dart';
import 'package:hayat_eg/features/data/model/food/food_category.dart';
import 'package:hayat_eg/features/data/model/food/food_unit.dart';
import 'package:hayat_eg/features/data/repository/CityRepository.dart';
import 'package:hayat_eg/features/data/repository/donation/food/food_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/food/food_repository.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../../../shared/Utils/Utils.dart';
import '../../../../../shared/component/component.dart';
import '../../../../../shared/component/constants.dart';

class CreateFoodDonationScreen extends StatefulWidget {
  @override
  State<CreateFoodDonationScreen> createState() =>
      _CreateFoodDonationScreenState();
}

class _CreateFoodDonationScreenState extends State<CreateFoodDonationScreen> {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  int? categoryId;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _foodExpirationDateController = TextEditingController();
  final communicationMethodController = TextEditingController();
  final telegramController = TextEditingController();
  final watsAppController = TextEditingController();
  final categoryController = TextEditingController();
  final quantityController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final _city = TextEditingController();
  final _foodUnit = TextEditingController();
  String communicationMethod = '';

  FoodDonationRepository _foodDonationRepository = sl();
  FoodRepository _foodRepository = sl();
  CityRepository _cityRepository = sl();

  String? sItem;
  Uint8List? myFile;

  List<City>? _cities = [];
  List<FoodUnit> _foodUnits = [];

  @override
  void initState() {
    super.initState();
    _foodRepository.listUnits().then((value) {
      setState(() {
        _foodUnits = value;
      });
    });

    _cityRepository.search('').then((value) {
      setState(() {
        _cities = value;
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
                  centerTitle: false,
                  title: Transform(
                    transform:
                        Matrix4.translationValues(size.width - 220, 0.0, 0.0),
                    child: const Text(
                      'Food Category',
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
                                                padding:
                                                    const EdgeInsets.all(10),
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
                                    child: requiredTextField(
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
                            postDescriptionTextFormField(
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
                                _city.text = _cities!
                                    .firstWhere((element) =>
                                        element.arabicName == value)
                                    .id
                                    .toString();
                              }),
                              selectedItem: null,
                              validator: (String? item) {
                                if (item == null) {
                                  return "City is Required";
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
                                child: FutureBuilder<List<FoodCategory>>(
                                  future: _foodRepository.listCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<FoodCategory> data = snapshot.data!;
                                      sItem = null;
                                      return DropdownButtonFormField(
                                        hint: const Text('Food Category'),
                                        iconEnabledColor: Colors.amber,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        value: sItem,
                                        items: data
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
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FutureBuilder<List<FoodUnit>>(
                                future: _foodRepository.listUnits(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<FoodUnit> data = snapshot.data!;

                                    sItem = null;
                                    return DropdownButtonFormField(
                                      hint: const Text('Food Unit'),
                                      iconEnabledColor: Colors.amber,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 30,
                                      ),
                                      value: sItem,
                                      items: data
                                          .map((item) => DropdownMenuItem(
                                              value: jsonEncode(
                                                  item.englishName.toString()),
                                              child: Text(
                                                (item.englishName.toString()),
                                              )))
                                          .toList(),
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          _foodUnit.text = _foodUnits
                                              .firstWhere((element) =>
                                                  jsonEncode(
                                                      element.englishName) ==
                                                  value)
                                              .id
                                              .toString();
                                        });
                                      },
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          focusColor: Colors.amber,
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
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Search',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black45),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          width: size.width - 230,
                                          child: requiredTextField(
                                            keyboardType: TextInputType.number,
                                            hint: 'Amount',
                                            onChanged: (value) {
                                              quantityController.text = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Quantity is Required';
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
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
                                              hint: 'please Inter Date',
                                              controller:
                                                  _foodExpirationDateController,
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Communication Method',
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
                                    onTap: () {
                                      communicationMethod = 'CHAT';
                                    },
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
                                    onTap: () {
                                      communicationMethod = 'PHONE';
                                    },
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
                                    onTap: () {
                                      communicationMethod = 'CHAT_AND_PHONE';
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myButton(
                                text: 'Submit',
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
    print(_foodExpirationDateController.text);
    final request = FoodDonationRequest(
        title: titleController.text,
        description: descriptionController.text,
        cityId: int.parse(_city.text),
        communicationMethod: communicationMethod,
        quantity: double.parse(quantityController.text),
        foodCategoryId: categoryId,
        foodUnitId: int.parse(_foodUnit.text),
        telegramLink: "https://t.me/${telegramController.text}",
        whatsappLink: "https://wa.me/${watsAppController.text}",
        foodExpirationDate: _foodExpirationDateController.text);


    final response = _foodDonationRepository.create(request);
    response.then((value) => {
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
}
