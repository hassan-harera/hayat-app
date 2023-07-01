import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/repository/need/book/book_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/need_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/need/book_need_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_tab_item.dart';
import 'package:hayat_eg/injection_container.dart';

import '../../../../shared/component/component.dart';
import '../../../../shared/component/constants.dart';
import '../notification/notificationScreen.dart';

class NeedsScreen extends StatefulWidget {
  const NeedsScreen({super.key});

  @override
  State<NeedsScreen> createState() => _NeedsScreen();
}

class _NeedsScreen extends State<NeedsScreen> {
  final formKey = GlobalKey<FormState>();

  String category = 'ALL';

  NeedRepository _needRepository = sl();
  BookNeedRepository _bookNeedRepository = sl();
  List<NeedResponse> _list = [];

  @override
  void initState() {
    super.initState();
    getAllNeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
                  },
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
    if (category == 'ALL') {
      getAllNeeds();
    } else if (category == 'MEDICINE') {
      getMedicineNeeds();
    } else if (category == 'BOOK') {
      getBookNeeds();
    } else if (category == 'BLOOD') {
      getBloodNeeds();
    }
  }

  void getAllNeeds() {
    _needRepository.search('').then((value) {
      setState(() {
        _list = value!;
      });
    });
  }

  void getMedicineNeeds() {}

  void getBookNeeds() {}

  void getBloodNeeds() {
    _bookNeedRepository.search('').then((value) {
      setState(() {
        _list = value!;
      });
    });
  }
}
