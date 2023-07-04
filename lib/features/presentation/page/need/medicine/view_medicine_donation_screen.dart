import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/datetime/datetime_utils.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/core/loading.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_response.dart';
import 'package:hayat_eg/features/data/repository/donation/medicine/medicine_donation_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/dialog/success_dialog.dart';
import 'package:hayat_eg/injection_container.dart';

class MedicineDonationItemScreen extends StatefulWidget {
  final int id;

  const MedicineDonationItemScreen({super.key, required this.id});

  @override
  State<MedicineDonationItemScreen> createState() =>
      _MedicineDonationItemScreenState(id);
}

class _MedicineDonationItemScreenState
    extends State<MedicineDonationItemScreen> {
  MedicineDonationResponse? _medicineDonation;
  final int id;

  _MedicineDonationItemScreenState(this.id);

  final MedicineDonationRepository _medicineDonationRepository = sl();

  @override
  initState() {
    super.initState();
    getMedicineDonation();
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
        title: const Text('Medicine Donation'),
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
                      _medicineDonation?.imageUrl ??
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
                          '${_medicineDonation?.reputation ?? 0}',
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
                                  _medicineDonation?.title ?? '',
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
                                    timeAgo(_medicineDonation?.donationDate!),
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
                                  ('${_medicineDonation?.user?.firstName!} ${_medicineDonation?.user?.lastName!}'),
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
                                      ('${_medicineDonation?.city?.arabicName}'),
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
                          _medicineDonation?.description ?? '',
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
                      child: Column(
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
                                'Medicine Name : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  'سينا لاكس 20',
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
                                'Medicine Unit : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  ' bottle',
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
                                'Medicine Amount : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  '${_medicineDonation?.quantity?.toString()} ${_medicineDonation?.medicineUnit?.englishName} Available',
                                  maxLines: 1,
                                  style: TextStyle(
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
                                'Medicine Expiration Date: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  _medicineDonation?.medicineExpirationDate ??
                                      '',
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
                                  _medicineDonation?.communicationMethod ??
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
                                  _medicineDonation?.whatsappLink ?? 'N/A',
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
                                  _medicineDonation?.telegramLink ?? 'N/A',
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
    final response = _medicineDonationRepository.downvote(id);
    response.then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: 'Your have upvoted this donation, Thank you!',
            );
          });

      getMedicineDonation();
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
    final response = _medicineDonationRepository.upvote(id);
    response.then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: 'Your have upvoted this donation, Thank you!',
            );
          });

      getMedicineDonation();
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

  void getMedicineDonation() {
    _medicineDonationRepository.get(id).then((value) {
      setState(() {
        print(_medicineDonation?.reputation);
        _medicineDonation = value;
      });
    });
  }
}
