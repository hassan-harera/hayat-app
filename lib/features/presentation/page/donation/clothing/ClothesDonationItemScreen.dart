import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/loading.dart';
import 'package:hayat_eg/features/data/model/donation/clothing/clothing_donation_response.dart';
import 'package:hayat_eg/features/data/repository/donation/clothing/clothing_donation_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/dialog/success_dialog.dart';
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
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: BarcodeWidget(
                            data: 'data for make QR ',
                            barcode: Barcode.qrCode(),
                            color: Colors.black,
                            width: 250,
                            height: 250,
                          ),
                          backgroundColor: Colors.grey[50],
                        ));
              },
              icon: const Icon(
                Icons.qr_code,
                color: Colors.black,
              )),
        ],
        title: const Text('Clothing Donation'),
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
                  Container(
                    height: size.height / 3.8,
                    width: size.width / 1.3,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(4, 108, 109, 1),
                        border: Border.all(
                          color: const Color(0xffE3EAF2),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.network(
                      _clothingDonation?.imageUrl ??
                          'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg',
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
                                downvote();
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _clothingDonation?.title ?? '',
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 3,
                                  ('${_clothingDonation?.user?.firstName!} ${_clothingDonation?.user?.lastName!}'),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Icon(Icons.location_on_outlined),
                                  ],
                                ),
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
                            fontSize: 16,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _clothingDonation?.description ?? '',
                          maxLines: 1,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donation Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Type : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'shorts',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Gender : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Men',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Quantity : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  '2 pieces}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Size : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Small',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Condition : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'good',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Clothes Season : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'Summer',
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
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
                                'Communication Method : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  _clothingDonation?.communicationMethod ??
                                      'Chat',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Whatsapp Link: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Linkify(
                                  maxLines: 1,
                                  text:
                                      _clothingDonation?.whatsappLink ?? 'N/A',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Telegram Link: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Linkify(
                                  maxLines: 1,
                                  text:
                                      _clothingDonation?.telegramLink ?? 'N/A',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
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

  void downvote() {
    final response = _clothingDonationRepository.downvote(id);
    response.then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const DonationSuccessDialog(
              message: 'Your have upvoted this donation, Thank you!',
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
            return const DonationSuccessDialog(
              message: 'Your have upvoted this donation, Thank you!',
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
