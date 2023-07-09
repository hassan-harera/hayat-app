import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_response.dart';
import 'package:hayat_eg/features/data/repository/donation/clothing/clothing_donation_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/communicatiion/telegram_details.dart';
import 'package:hayat_eg/features/presentation/widgets/communicatiion/whatsapp_details.dart';
import 'package:hayat_eg/features/presentation/widgets/dialog/success_dialog.dart';
import 'package:hayat_eg/features/presentation/widgets/images/downloaded_image_utils.dart';
import 'package:hayat_eg/injection_container.dart';

class ClothesDonationItemScreen extends StatefulWidget {
  final int id;

  const ClothesDonationItemScreen({super.key, required this.id});

  @override
  State<ClothesDonationItemScreen> createState() =>
      _ClothesDonationItemScreenState(id);
}

class _ClothesDonationItemScreenState extends State<ClothesDonationItemScreen> {
  ClothingDonationResponse? _clothingDonation;
  final int id;

  _ClothesDonationItemScreenState(this.id);

  final ClothingDonationRepository _clothingDonationRepository = sl();

  @override
  initState() {
    super.initState();
    getClothingDonation();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: BarcodeWidget(
                            data: _clothingDonation?.qrCode ?? 'QR',
                            barcode: Barcode.qrCode(),
                            color: Colors.black,
                            width: 250,
                            height: 250,
                            drawText: true,
                          ),
                          backgroundColor: Colors.grey[50],
                        ));
              },
              icon: const Icon(
                Icons.qr_code,
                color: Colors.black,
              )),
        ],
        title: const Text('Clothes Donation'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          top: size.height / 45,
        ),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FullScreenWidget(
                    disposeLevel: DisposeLevel.High,
                    child: Container(
                      height: size.height / 3.8,
                      width: size.width / 1.3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white30,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: DownloadedImage(
                        imageUrl: _clothingDonation?.imageUrl ?? '',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                upvote();
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.black,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${_clothingDonation?.reputation ?? 0}',
                          maxLines: 1,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                downVote();
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 45,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _clothingDonation?.title ?? 'N/A',
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    timeAgo(_clothingDonation?.donationDate!),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Icon(Icons.date_range),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 3,
                                  ('${_clothingDonation?.user?.firstName!} ${_clothingDonation?.user?.lastName!}'),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    ('${_clothingDonation?.city?.arabicName}'),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Icon(Icons.location_on_outlined),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: ListView(shrinkWrap: true, children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _clothingDonation?.description ?? 'N/A',
                          maxLines: 1,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Clothes Type:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _clothingDonation?.clothingType
                                                    ?.arabicName ??
                                                'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Clothes  Gender:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 29,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _clothingDonation?.clothingCategory
                                                    ?.arabicName ??
                                                'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Clothes Quantity:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Expanded(
                                          child: Text(
                                            ' ${_clothingDonation?.quantity}' ??
                                                'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Clothes Size: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 55,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _clothingDonation?.clothingSize
                                                    ?.arabicName ??
                                                'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Clothes Condition:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _clothingDonation?.clothingCondition
                                                    ?.arabicName ??
                                                'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Clothes Season: ',
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _clothingDonation?.clothingSeason
                                                    ?.arabicName ??
                                                'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Social Media',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Communication Method:    ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  _clothingDonation?.communicationMethod ??
                                      'Chat',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          WhatsappDetails(
                              whatsappLink: _clothingDonation?.whatsappLink),
                          const SizedBox(
                            height: 10,
                          ),
                          TelegramDetails(
                            telegramLink: _clothingDonation?.telegramLink,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void downVote() {
    final response = _clothingDonationRepository.downvote(id);
    response.then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: 'Your have down voted this donation,Thanks!',
            );
          });

      getClothingDonation();
    });

    response.onError((error, stackTrace) {
      if (error is BadRequestException) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Unable to upvote donation'),
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

  void upvote() async {
    final response = _clothingDonationRepository.upvote(id);
    response.then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: ' Your have up voted this donation,Thanks! ',
            );
          });

      getClothingDonation();
    });

    response.onError((error, stackTrace) {
      if (error is BadRequestException) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Unable to upvote donation'),
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

  void getClothingDonation() {
    _clothingDonationRepository.get(id).then((value) {
      setState(() {
        print(_clothingDonation?.reputation);
        _clothingDonation = value;
      });
    });
  }
}
