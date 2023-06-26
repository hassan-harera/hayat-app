import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/layout/Categories/socialMediaCommunication.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat-egLayout.dart';
import 'package:hayat_eg/models/Clothes/clothesCategory.dart';

import 'package:hayat_eg/models/Clothes/clothesType.dart';
import 'package:hayat_eg/shared/Utils/Utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Clothes/clothesSize.dart';
import '../../services/getRequest/clothes/clothes-api-get.dart';

import '../../shared/component/component.dart';
import '../../shared/component/constans.dart';
import '../HayatLayout/LayOutCubit/HayatLaoutCubit.dart';
import '../HayatLayout/LayOutCubit/LayoutState.dart';

class ClothesCategoryScreen extends StatefulWidget {
  @override
  State<ClothesCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<ClothesCategoryScreen> {
  Uint8List ? _file;

  _selectImage(BuildContext context)async{
    final size =MediaQuery.of(context).size;
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: const Text('Create post '),
        children: [
          SimpleDialogOption(
            padding:const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.camera,color: Colors.amber,),
                SizedBox(width:size.width/30,),
                const Text('Take a photo from camera',),
              ],
            ),
            onPressed: ()async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera );
              setState(() {
                _file=file;
              });

            },
          ),
          SimpleDialogOption(
            padding:const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.image),
                SizedBox(width:size.width/30,),
                const Text('chose from gallery '),
              ],
            ),
            onPressed: ()async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery );
              setState(() {
                _file=file;
              });

            },
          ),
        ],
      );
    },);
  }
  final formKey = GlobalKey<FormState>();
  var descriptionController=TextEditingController();
AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          final size=MediaQuery.of(context).size;
          // final User user =Provider.of<UserProvider>(context);
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Clothes Category',
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
                                              BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: MemoryImage(_file!),
                                                fit: BoxFit.fill,
                                                alignment: FractionalOffset
                                                    .topCenter,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                myStaticTextFormField(
                                  width: size.width-160,

                                  hint: 'Title',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please add Title';
                                    }
                                  },
                                ),
                              ],
                            ),
                            myDescriptionTextFormField(controller: descriptionController),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothesCategory>>(
                                  future: ClothesServices()
                                      .getClothesCategory(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothesCategory> units =
                                      snapshot.data!;
                                      String? sItem = jsonEncode(units[0]
                                          .englishName
                                          .toString());
                                      return DropdownButtonFormField(

                                        hint: const Text('Size'),
                                        iconEnabledColor: Colors.amber,
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
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FutureBuilder<List<ClothesType>>(
                                  future:ClothesServices()
                                      .getClothesType(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<ClothesType> units =
                                      snapshot.data!;
                                      String? sItem = jsonEncode(units[0]
                                          .englishName
                                          .toString());
                                      return DropdownButtonFormField(

                                        hint: const Text('Size'),
                                        iconEnabledColor: Colors.amber,
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
                                SizedBox(width: 10,),
                                // SizedBox(
                                //   width: 150,
                                //   child: myStaticTextFormField(
                                //     hint: 'Size',
                                //     validator: (value) {
                                //       if (value!.isEmpty) {
                                //         return 'Please inter size';
                                //       }
                                //     },
                                //   ),
                                // ),
                                SizedBox(
                                    width: 150,
                                    child: FutureBuilder<List<ClothesSize>>(
                                      future: ClothesServices()
                                          .getClothesSize(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<ClothesSize> units =
                                          snapshot.data!;
                                          String? sItem = jsonEncode(units[0]
                                              .englishName
                                              .toString());
                                          return DropdownButtonFormField(

                                            hint: const Text('Size'),
                                            iconEnabledColor: Colors.amber,
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
                                    )),
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
                                    myNavigator(context,
                                        const HayatLayoutScreen());
                                    formKey.currentState!.save();
                                  }else{
                                    setState(() {

                                    });
                                    autoValidateMode=AutovalidateMode.always;
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
