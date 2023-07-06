import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/data/repository/need/need_repository.dart';
import 'package:hayat_eg/features/presentation/page/donation/book/create_book_donation_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/medicine/create_medicine_donation_screen.dart';
import 'package:hayat_eg/features/presentation/widgets/homeBuilder.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_item.dart';
import 'package:hayat_eg/injection_container.dart';

import '../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../layout/Search/SearchScreen.dart';
import '../../../shared/component/constants.dart';
import 'donation/clothing/create_clothing_donation_screen.dart';
import 'donation/donations_screen.dart';
import 'donation/food/create_food_donation_screen.dart';
import 'notification/notificationScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final NeedRepository _needRepository = sl();
  List<NeedResponse> _list = [];

  @override
  void initState() {
    super.initState();
    getNeeds();
  }

  getNeeds() async {
    _list = (await _needRepository.search(''))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final size = MediaQuery.of(context).size;
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.profile_circled,
                  size: 30,
                  color: Color(0xff20ADDC),
                ),
              ),
              title: const Text(
                'Mohamed Boraie',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              actions: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: IconButton(
                    onPressed: () {
                      navigate(context, notificationScreen());
                    },
                    icon: const Icon(
                      Icons.notifications,
                      size: 26,
                    ),
                    color: const Color(0xff20ADDC),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: IconButton(
                    onPressed: () {
                      navigate(context, SearchScreen());
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 26,
                    ),
                    color: const Color(0xff20ADDC),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ConditionalBuilder(
                          condition: true,
                          builder: (context) => homeBuilder(imageHeight: 100),
                          fallback: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Donation Categories',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          navigate(context, DonationsScreen());
                                        },
                                        child: const Text(
                                          'Sea All ',
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            layoutCubit
                                                .changCategoryTitleToBook();
                                            navigate(context,
                                                BookDonationFormScreen());
                                          },
                                          child: categoryProvider(
                                            image: 'assets/bookCategory.png',
                                            text: 'B00kS',
                                            width: size.width / 2.7,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            layoutCubit
                                                .changCategoryTitleToMedicine();
                                            navigate(context,
                                                CreateFoodDonationScreen());
                                          },
                                          child: categoryProvider(
                                            image: 'assets/foodCategory.png',
                                            text: 'food',
                                            width: size.width / 2.7,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            layoutCubit
                                                .changCategoryTitleToMedicine();
                                            navigate(context,
                                                const MedicineCategoryScreen());
                                          },
                                          child: categoryProvider(
                                            image:
                                                'assets/medicineCategory.png',
                                            text: 'medicine',
                                            width: size.width / 2.7,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            layoutCubit
                                                .changCategoryTitleToBook();
                                            navigate(context,
                                                const CreateClothingDonationScreen());
                                          },
                                          child: categoryProvider(
                                            image: 'assets/clothesCategory.png',
                                            text: 'clothes',
                                            width: size.width / 2.7,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Needs',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          // NavegateTo(context, catigoriesScreen());
                                        },
                                        child: const Text(
                                          'Sea All ',
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: size.height / 30,
                                                ),
                                                child: NeedItem(
                                                    context, _list[index]),
                                              ),
                                          itemCount: _list.length)),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}

//
