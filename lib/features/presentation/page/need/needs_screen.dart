import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/repository/need/book/book_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/medicine/medicine_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/need_repository.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_item.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/shared/component/constants.dart';

class NeedsScreen extends StatefulWidget {
  const NeedsScreen({super.key});

  @override
  State<NeedsScreen> createState() => _NeedsScreen();
}

class _NeedsScreen extends State<NeedsScreen> {
  final formKey = GlobalKey<FormState>();

  final query = TextEditingController();
  String category = 'ALL';
  bool sColor1 = false;
  bool sColor2 = false;
  bool sColor3 = false;
  bool sColor4 = false;
  bool sColor5 = false;
  List<NeedResponse> _list = [];

  final NeedRepository _needRepository = sl();
  final BookNeedRepository _bookNeedRepository = sl();
  final MedicineNeedRepository _medicineNeedRepository = sl();

  @override
  void initState() {
    super.initState();
    _getAllNeeds();
    category = 'ALL';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        constraints:
                            const BoxConstraints(minHeight: 30, maxHeight: 50),
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
                        getNeeds();
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
                height: 40.0,
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
                        getNeeds();
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    defaultTextBottom(
                      color: sColor2 ? const Color(0xff20ADDC) : Colors.white,
                      borderColor:
                          sColor2 ? const Color(0xff20ADDC) : Colors.white,
                      textColor: sColor2 ? Colors.white : Colors.black54,
                      text: 'Medicines',
                      onPressed: () {
                        setState(() {});

                        category = 'MEDICINE';
                        _colorController(category);
                        getNeeds();
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    defaultTextBottom(
                      color: sColor3 ? const Color(0xff20ADDC) : Colors.white,
                      borderColor:
                          sColor3 ? const Color(0xff20ADDC) : Colors.white,
                      textColor: sColor3 ? Colors.white : Colors.black54,
                      text: 'Books',
                      onPressed: () {
                        setState(() {});

                        category = 'BOOK';
                        _colorController(category);
                        getNeeds();
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    defaultTextBottom(
                      color: sColor4 ? const Color(0xff20ADDC) : Colors.white,
                      borderColor:
                          sColor4 ? const Color(0xff20ADDC) : Colors.white,
                      textColor: sColor4 ? Colors.white : Colors.black54,
                      text: 'Blood',
                      onPressed: () {
                        setState(() {});

                        category = 'BLOOD';
                        _colorController(category);
                        getNeeds();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
        ),
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

  void _getBloodNeeds() {}

  void _colorController(category) {
    switch (category) {
      case 'MEDICINE':
        {
          sColor1 = false;
          sColor2 = true;
          sColor3 = false;
          sColor4 = false;
        }
        break;
      case 'BOOK':
        {
          sColor1 = false;
          sColor2 = false;
          sColor3 = true;
          sColor4 = false;
        }
        break;
      case 'BLOOD':
        {
          sColor1 = false;
          sColor2 = false;
          sColor3 = false;
          sColor4 = true;
        }
        break;
      default:
        {
          sColor1 = true;
          sColor2 = false;
          sColor3 = false;
          sColor4 = false;
        }
        break;
    }
  }
}
