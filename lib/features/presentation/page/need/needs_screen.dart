import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/repository/need/blood/blood_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/book/book_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/medicine/medicine_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/need_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_tab_item.dart';
import 'package:hayat_eg/injection_container.dart';

class NeedsScreen extends StatefulWidget {
  const NeedsScreen({super.key});

  @override
  State<NeedsScreen> createState() => _NeedsScreen();
}

class _NeedsScreen extends State<NeedsScreen> {
  final formKey = GlobalKey<FormState>();

  final query = TextEditingController();
  String category = 'ALL';
  List<NeedResponse> _list = [];

  final NeedRepository _needRepository = sl();
  final BookNeedRepository _bookNeedRepository = sl();
  final BloodNeedRepository _bloodNeedRepository = sl();
  final MedicineNeedRepository _medicineNeedRepository = sl();

  @override
  void initState() {
    super.initState();
    _getAllNeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body: Column(
        children: [
          Padding(
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
                      _getNeeds();
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
          SizedBox(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TabItem(
                  text: 'All',
                  onPressed: () {
                    category = 'ALL';
                    _getNeeds();
                  },
                ),
                TabItem(
                    text: 'Medicines',
                    onPressed: () {
                      category = 'MEDICINE';
                      _getNeeds();
                    }),
                TabItem(
                  text: 'Books',
                  onPressed: () {
                    category = 'BOOK';
                    _getNeeds();
                  },
                ),
                TabItem(
                  text: 'Blood',
                  onPressed: () {
                    category = 'BLOOD';
                    _getNeeds();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(4.0),
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return needItem(
                  context,
                  _list[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _getNeeds() async {
    setState(() {
      _list = [];
    });

    if (category == 'ALL') {
      _getAllNeeds();
    } else if (category == 'MEDICINE') {
      _getMedicineNeeds();
    } else if (category == 'BOOK') {
      _getBookNeeds();
    } else if (category == 'BLOOD') {
      _getBloodNeeds();
    }
  }

  void _getAllNeeds() {
    _needRepository.search(query.text).then((value) {
      setState(() {
        _list = value!;
      });
    });
  }

  void _getMedicineNeeds() {
    _medicineNeedRepository.search(query.text).then((value) {
      setState(() {
        _list = value!;
      });
    });
  }

  void _getBookNeeds() {
    _bookNeedRepository.search(query.text).then((value) {
      setState(() {
        _list = value!;
      });
    });
  }

  void _getBloodNeeds() {
    _bloodNeedRepository.search(query.text).then((value) {
      setState(() {
        _list = value!;
      });
    });
  }
}
