import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/repository/need/blood/blood_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/book/book_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/medicine/medicine_need_repository.dart';
import 'package:hayat_eg/features/data/repository/need/need_repository.dart';
import 'package:hayat_eg/features/presentation/page/notification/notificationScreen.dart';
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
  bool sColor1 = true;
  bool sColor2 = false;
  bool sColor3 = false;
  bool sColor4 = false;
  bool sColor5 = false;
  List<NeedResponse> _list = [];

  final NeedRepository _needRepository = sl();
  final BookNeedRepository _bookNeedRepository = sl();
  final BloodNeedRepository _bloodNeedRepository = sl();
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
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
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
                          fillColor: const Color(0xffCED9E9).withOpacity(.5),
                          filled: true,
                          constraints: const BoxConstraints(
                              minHeight: 30, maxHeight: 50),
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: const Color(0xff20ADDC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff20ADDC), width: 2),
                              borderRadius: BorderRadius.circular(40.0)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xffCED9E9).withOpacity(.5)),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onChanged: (value) {
                          _getNeeds();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Color(0xff20ADDC),
                        size: 30,
                      ),
                      onPressed: () {
                        navigate(context, notificationScreen());
                      },
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
                      CircleAvatar(
                        backgroundColor:
                            const Color(0xffCED9E9).withOpacity(.5),
                        minRadius: 20,
                        child: const Icon(Icons.filter_list_alt,
                            color: Color(0xff20ADDC)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: const Color(0xffCED9E9).withOpacity(.5),
                        borderColor: sColor1
                            ? const Color(0xff20ADDC)
                            : const Color(0xffCED9E9).withOpacity(.5),
                        textColor: sColor1 ? Colors.black : Colors.black54,
                        text: 'All',
                        onPressed: () {
                          setState(() {});

                          category = 'ALL';
                          _colorController(category);
                          _getNeeds();
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: const Color(0xffCED9E9).withOpacity(.5),
                        borderColor: sColor2
                            ? const Color(0xff20ADDC)
                            : const Color(0xffCED9E9).withOpacity(.5),
                        text: 'Medicines',
                        textColor: sColor2 ? Colors.black : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'MEDICINE';
                          _colorController(category);
                          _getNeeds();
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: const Color(0xffCED9E9).withOpacity(.5),
                        borderColor: sColor3
                            ? const Color(0xff20ADDC)
                            : const Color(0xffCED9E9).withOpacity(.5),
                        text: 'Books',
                        textColor: sColor3 ? Colors.black : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'BOOK';
                          _getNeeds();
                          _colorController(category);
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      defaultTextBottom(
                        color: const Color(0xffCED9E9).withOpacity(.5),
                        borderColor: sColor4
                            ? const Color(0xff20ADDC)
                            : const Color(0xffCED9E9).withOpacity(.5),
                        text: 'BLOOD',
                        textColor: sColor4 ? Colors.black : Colors.black54,
                        onPressed: () {
                          setState(() {});
                          category = 'BLOOD';
                          _colorController(category);
                          _getNeeds();
                        },
                      ),
                      const SizedBox(
                        width: 5,
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
                        return NeedItem(
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
