import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/presentation/page/donation/book/create_book_donation_screen.dart';
import 'package:hayat_eg/features/presentation/page/donation/medicine/create_medicine_donation_screen.dart';
import 'package:hayat_eg/features/presentation/widgets/homeBuilder.dart';
import '../../../shared/component/constants.dart';
import 'donation/clothing/clothing_donation_form.dart';
import 'donation/food/FoodCatigory.dart';
import '../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import 'notification/notificationScreen.dart';
import '../../../layout/Search/SearchScreen.dart';
import 'donation/donations_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Mohamed Boraie',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              actions: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: IconButton(
                    onPressed: () {
                      myNavigator(context, notificationScreen());
                    },
                    icon: const Icon(
                      Icons.notifications,
                      size: 26,
                    ),
                    color: Color(0xff20ADDC),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: IconButton(
                    onPressed: () {
                      myNavigator(context, SearchScreen());
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 26,
                    ),
                    color: Color(0xff20ADDC),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: true,
                      builder: (context) => homeBuilder(imageHeight: 100),
                      fallback: (context) => const CircularProgressIndicator(),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Donation Categories',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            myNavigator(context, DonationsScreen());
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
                              layoutCubit.changCategoryTitleToBook();
                              myNavigator(context, BookDonationFormScreen());
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
                              layoutCubit.changCategoryTitleToMedicine();
                              myNavigator(context, FoodCategoryScreen());
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
                              layoutCubit.changCategoryTitleToMedicine();
                              myNavigator(context, MedicineCategoryScreen());
                            },
                            child: categoryProvider(
                              image: 'assets/medicineCategory.png',
                              text: 'medicine',
                              width: size.width / 2.7,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              layoutCubit.changCategoryTitleToBook();
                              myNavigator(context, ClothesCategoryScreen());
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
                          'Needs Categories',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              layoutCubit.changCategoryTitleToBook();
                              myNavigator(context, BookDonationFormScreen());
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
                              layoutCubit.changCategoryTitleToMedicine();
                              myNavigator(context, FoodCategoryScreen());
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
                              layoutCubit.changCategoryTitleToMedicine();
                              myNavigator(context, MedicineCategoryScreen());
                            },
                            child: categoryProvider(
                              image: 'assets/medicineCategory.png',
                              text: 'medicine',
                              width: size.width / 2.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//
