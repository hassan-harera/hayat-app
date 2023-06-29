import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/repository/donation/book_donation_repository.dart';
import 'package:hayat_eg/features/presentation/page/city/city_search.dart';
import 'package:hayat_eg/features/presentation/page/donation/book/view_book_donation_screen.dart';
import 'package:hayat_eg/shared/Utils/Utils.dart';
import 'package:hayat_eg/shared/component/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../../../shared/component/component.dart';

class BookDonationFormScreen extends StatefulWidget {
  @override
  State<BookDonationFormScreen> createState() => _BookDonationFormScreenState();
}

class _BookDonationFormScreenState extends State<BookDonationFormScreen> {
  final formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var bookTitleController = TextEditingController();
  var bookAuthorController = TextEditingController();
  var bookPublisherController = TextEditingController();
  var bookQuantityController = TextEditingController();
  var bookLanguageController = TextEditingController();
  var bookCityController = TextEditingController();
  var bookPublicationYearController = TextEditingController();
  var bookSubTitleController = TextEditingController();
  var telegramController = TextEditingController();
  var watsAppController = TextEditingController();
  late String communicationMethod;
  late Long cityId;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  BookDonationRepository _bookDonationRepository = sl();
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
          final size = MediaQuery.of(context).size;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Book Donation',
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
                                  controller: titleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please add Title';
                                    }
                                  },
                                ),
                              ],
                            ),
                            myStaticTextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please add Book Category';
                                }
                              },
                              hint: 'Book Title',
                              controller: bookTitleController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myStaticTextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please add Book Category';
                                }
                              },
                              hint: 'Book Sub Title',
                              controller: bookSubTitleController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myDescriptionTextFormField(
                                controller: descriptionController),
                            const SizedBox(
                              height: 10,
                            ),
                            myStaticTextFormField(
                              controller: bookLanguageController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please inter Book Language';
                                }
                              },
                              hint: 'Book Language',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myStaticTextFormField(
                              controller: bookQuantityController,
                              hint: 'Quantity',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please inter publisher';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myStaticTextFormField(
                              controller: bookPublisherController,
                              hint: 'Book Publisher',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please inter publisher';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myStaticTextFormField(
                              controller: bookAuthorController,
                              hint: 'Book Author',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please inter publisher';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ExprirationDate(
                              hint: '         Book Publication Year',
                              controller: bookPublicationYearController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  myNavigator(context, SearchScreen());
                                });
                              },
                              child: myStaticTextFormField(
                                hint: 'City',
                                controller: bookCityController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please inter publisher';
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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
                                      communicationMethod = 'CHAT';
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
                                      communicationMethod = 'PHONE';
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
                                      layoutCubit.communicationTool = value;
                                      layoutCubit.changRadioValue();
                                      communicationMethod = 'CHAT_AND_PHONE';
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Social Media',
                                  style: TextStyle(fontSize: 20),
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
                            myButton(
                                text: 'Submit',
                                onTap: () async {
                                  onSubmit();
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

  void onSubmit() {
    final request = BookDonationRequest(
      title: titleController.text,
      description: descriptionController.text,
      bookTitle: bookTitleController.text,
      bookSubTitle: bookSubTitleController.text,
      communicationMethod: communicationMethod,
      cityId: 1,
    );

    final response = _bookDonationRepository.create(request);
    response.onError((error, stackTrace) {});

    response.then(
        (value) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDonationScreen(),
                ),
              )
            }, onError: (error, stackTrace) {
      error as BadRequestException;
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
      stackTrace.printError();
    });
  }
}
