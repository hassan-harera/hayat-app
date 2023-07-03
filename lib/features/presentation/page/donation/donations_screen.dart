import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/donation/DonationResponse.dart';
import 'package:hayat_eg/features/data/repository/donation/book/book_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/clothing/clothing_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/food/food_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/donation/medicine/medicine_donation_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/donation/donation_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_tab_item.dart';
import 'package:hayat_eg/injection_container.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  final query = TextEditingController();

  List<DonationResponse> _donations = [];
  String category = 'ALL';

  final DonationRepository _donationRepository = sl();
  final FoodDonationRepository _foodDonationRepository = sl();
  final ClothingDonationRepository _clothingDonationRepository = sl();
  final BookDonationRepository _bookDonationRepository = sl();
  final MedicineDonationRepository _medicineDonationRepository = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: query,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    _getDonations();
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              const Icon(Icons.photo_filter),
              const SizedBox(width: 8.0),
              const Icon(Icons.sort),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TabItem(
                  text: 'All',
                  onPressed: () {
                    category = 'ALL';
                    _getDonations();
                  },
                ),
                TabItem(
                    text: 'Medicines',
                    onPressed: () {
                      category = 'MEDICINE';
                      _getDonations();
                    }),
                TabItem(
                  text: 'Books',
                  onPressed: () {
                    category = 'BOOK';
                    _getDonations();
                  },
                ),
                TabItem(
                  text: 'Food',
                  onPressed: () {
                    category = 'FOOD';
                    _getDonations();
                  },
                ),
                TabItem(
                  text: 'Clothes',
                  onPressed: () {
                    category = 'CLOTHING';
                    _getDonations();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
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
}
