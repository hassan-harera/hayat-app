import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_request.dart';
import 'package:hayat_eg/features/data/model/donation/book/book_donation_response.dart';
import 'package:hayat_eg/features/data/repository/CityRepository.dart';
import 'package:hayat_eg/features/data/repository/donation/book/book_donation_repository.dart';
import 'package:hayat_eg/features/presentation/page/donation/book/view_book_donation_item_screen.dart';
import 'package:hayat_eg/features/presentation/widgets/dialog/success_dialog.dart';
import 'package:hayat_eg/features/presentation/widgets/donation/city_dropmenu.dart';
import 'package:hayat_eg/injection_container.dart';
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
  late int cityId;
  bool _isLoading = false;
  List<City>? _cities = [];

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final BookDonationRepository _bookDonationRepository = sl();
  Uint8List? _file;

  CityRepository _cityRepository = sl();

  @override
  void initState() {
    super.initState();
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
                  elevation: 1.0,
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Book Donation',
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
                            requiredTextField(
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
                            CitiesDropMenu(
                                cities: _cities ?? [],
                                onSelectedCity: (value) => setState(() {
                                      cityId = _cities!
                                          .firstWhere((element) =>
                                              element.arabicName == value)
                                          .id;
                                    })),
                            const SizedBox(
                              height: 15,
                            ),
                            requiredTextField(
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
                            descriptionTextField(
                                controller: descriptionController),
                            const SizedBox(
                              height: 10,
                            ),
                            requiredTextField(
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
                            requiredTextField(
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
                            requiredTextField(
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
                            requiredTextField(
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
                              hint: 'Book Publication Year',
                              controller: bookPublicationYearController,
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
                                          communicationMethod = 'CHAT';
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
                                          communicationMethod = 'PHONE';
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
                                          communicationMethod =
                                              'CHAT_AND_PHONE';
                                        }),
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
      quantity: int.parse(bookQuantityController.text),
      telegramLink: 'https://t.me/${telegramController.text}',
      whatsappLink: 'https://wa.me/${watsAppController.text}',
      cityId: cityId,
    );

    final response = _bookDonationRepository.create(request);
    response.then((value) => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SuccessDialog(
                  message: 'Your Donation Request has been sent successfully',
                );
              }),
          value as BookDonationResponse,
          uploadImage(value.id as int),
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
      setState(() {
        _isLoading = true;
      });

      _bookDonationRepository
          .updateImage(id, _file as Uint8List)
          .then((value) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDonationDetailsScreen(id: id),
                  ),
                )
              });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDonationDetailsScreen(id: id),
        ),
      );
    }
  }
}
