import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/repository/donation/donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/book/book_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/clothing/clothing_donation_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/donation/donation_item.dart';
import 'package:hayat_eg/features/data/repository/donation/food/food_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/medicine/medicine_donation_repository.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  final query = TextEditingController();

  bool sColor1 = false;
  bool sColor2 = false;
  bool sColor3 = false;
  bool sColor4 = false;
  bool sColor5 = false;
  List<DonationResponse> _donations = [];
  String category = 'ALL';

  final DonationRepository _donationRepository = sl();
  final FoodDonationRepository _foodDonationRepository = sl();
  final ClothingDonationRepository _clothingDonationRepository = sl();
  final BookDonationRepository _bookDonationRepository = sl();
  final MedicineDonationRepository _medicineDonationRepository = sl();

  @override
  void initState() {
    super.initState();
    _getAllNeeds();
    category = 'ALL';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //    return Scaffold(
    //       appBar: AppBar(
    //         title: Padding(
    //           padding: const EdgeInsets.all(16.0),
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   controller: query,
    //                   decoration: InputDecoration(
    //                     hintText: 'Search',
    //                     prefixIcon: const Icon(Icons.search),
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     ),
    //                   ),
    //                   onChanged: (value) {
    //                     _getDonations();
    //                   },
    //                 ),
    //               ),
    //               const SizedBox(width: 16.0),
    //               const Icon(Icons.photo_filter),
    //               const SizedBox(width: 8.0),
    //               const Icon(Icons.sort),
    //             ],
    //           ),
    //         ),
    //       ),
    //       body: Column(
    //         children: [
    //           SizedBox(
    //             height: 50.0,
    //             child: ListView(
    //               scrollDirection: Axis.horizontal,
    //               children: [
    //                 TabItem(
    //                   text: 'All',
    //                   onPressed: () {
    //                     category = 'ALL';
    //                     _getDonations();
    //                   },
    //                 ),
    //                 TabItem(
    //                     text: 'Medicines',
    //                     onPressed: () {
    //                       category = 'MEDICINE';
    //                       _getDonations();
    //                     }),
    //                 TabItem(
    //                   text: 'Books',
    //                   onPressed: () {
    //                     category = 'BOOK';
    //                     _getDonations();
    //                   },
    //                 ),
    //                 TabItem(
    //                   text: 'Food',
    //                   onPressed: () {
    //                     category = 'FOOD';
    //                     _getDonations();
    //                   },
    //                 ),
    //                 TabItem(
    //                   text: 'Clothes',
    //                   onPressed: () {
    //                     category = 'CLOTHING';
    //                     _getDonations();
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.all(16.0),
    //               child: ListView.builder(
    //                 padding: const EdgeInsets.all(10.0),
    //                 itemCount: _donations.length,
    //                 itemBuilder: (context, index) {
    //                   return DonationItem(
    //                     _donations[index],
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: query,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          fillColor: Colors.white,
                          filled: true,
                          constraints: const BoxConstraints(
                              minHeight: 30, maxHeight: 50),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onChanged: (value) {
                          _getDonations();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_filter),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      defaultTextBottom(
                        color: sColor1 ? const Color(0xff20ADDC) : Colors.white,
                        borderColor:
                            sColor1 ? const Color(0xff20ADDC) : Colors.white,
                        textColor: sColor1 ? Colors.white : Colors.black54,
                        text: 'All',
                        onPressed: () {
                          setState(() {});

                          category = 'ALL';
                          _colorController(category);
                          _getDonations();
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: sColor2 ? const Color(0xff20ADDC) : Colors.white,
                        borderColor:
                            sColor2 ? const Color(0xff20ADDC) : Colors.white,
                        text: 'Medicines',
                        textColor: sColor2 ? Colors.white : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'MEDICINE';
                          _colorController(category);
                          _getDonations();
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: sColor3 ? const Color(0xff20ADDC) : Colors.white,
                        borderColor:
                            sColor3 ? const Color(0xff20ADDC) : Colors.white,
                        text: 'Books',
                        textColor: sColor3 ? Colors.white : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'BOOK';
                          _getDonations();
                          _colorController(category);
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: sColor4 ? const Color(0xff20ADDC) : Colors.white,
                        borderColor:
                            sColor4 ? const Color(0xff20ADDC) : Colors.white,
                        text: 'Food',
                        textColor: sColor4 ? Colors.white : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'FOOD';
                          _colorController(category);
                          _getDonations();
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: sColor5 ? const Color(0xff20ADDC) : Colors.white,
                        borderColor:
                            sColor5 ? const Color(0xff20ADDC) : Colors.white,
                        text: 'Clothes',
                        textColor: sColor5 ? Colors.white : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'CLOTHING';
                          _getDonations();
                          _colorController('CLOTHING');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      itemCount: _donations.length,
                      itemBuilder: (context, index) {
                        return DonationItem(
                          _donations[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getDonations() async {
    setState(() {
      _donations = [];
    });

    if (category == 'ALL') {
      _getAllNeeds();
    } else if (category == 'MEDICINE') {
      _getMedicineDonations();
    } else if (category == 'BOOK') {
      _getBookDonations();
    } else if (category == 'FOOD') {
      _getFoodDonations();
    } else if (category == 'CLOTHING') {
      _getClothingDonations();
    }
  }

  void _getAllNeeds() {
    _donationRepository.search(query.text).then((value) {
      setState(() {
        _donations = value!;
      });
    });
  }

  void _getMedicineDonations() {
    _medicineDonationRepository.search(query.text).then((value) {
      setState(() {
        _donations = value!;
      });
    });
  }

  void _getBookDonations() {
    _bookDonationRepository.search(query.text).then((value) {
      setState(() {
        _donations = value!;
      });
    });
  }

  void _getFoodDonations() {
    _foodDonationRepository.search(query.text).then((value) {
      setState(() {
        _donations = value!;
      });
    });
  }

  void _getClothingDonations() {
    _clothingDonationRepository.search(query.text).then((value) {
      setState(() {
        _donations = value!;
      });
    });
  }

  void _colorController(category) {
    switch (category) {
      case 'MEDICINE':
        {
          sColor1 = false;
          sColor2 = true;
          sColor3 = false;
          sColor4 = false;
          sColor5 = false;
        }
        break;
      case 'CLOTHING':
        {
          sColor1 = false;
          sColor2 = false;
          sColor3 = false;
          sColor4 = false;
          sColor5 = true;
        }
        break;
      case 'BOOK':
        {
          sColor1 = false;
          sColor2 = false;
          sColor3 = true;
          sColor4 = false;
          sColor5 = false;
        }
        break;
      case 'FOOD':
        {
          sColor1 = false;
          sColor2 = false;
          sColor3 = false;
          sColor4 = true;
          sColor5 = false;
        }
        break;
      default:
        {
          sColor1 = true;
          sColor2 = false;
          sColor3 = false;
          sColor4 = false;
          sColor5 = false;
        }
        break;
    }
  }
}
