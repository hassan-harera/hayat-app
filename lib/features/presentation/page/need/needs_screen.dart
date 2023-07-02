import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
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
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: query,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      getNeeds();
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Icon(Icons.photo_filter),
                SizedBox(width: 8.0),
                Icon(Icons.sort),
              ],
            ),
          ),
          Container(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TabItem(
                  text: 'All',
                  onPressed: () {
                    category = 'ALL';
                    getNeeds();
                  },
                ),
                TabItem(
                  text: 'Medicines',
                  onPressed: () {
                    category = 'MEDICINE';
                    getNeeds();
                  }
                ),
                TabItem(
                  text: 'Books',
                  onPressed: () {
                    category = 'BOOK';
                    getNeeds();
                  },
                ),
                TabItem(
                  text: 'Blood',
                  onPressed: () {
                    category = 'BLOOD';
                    getNeeds();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return needItem(
                    context,
                    _list[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getNeeds() async {
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

  }
}
