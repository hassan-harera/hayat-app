import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';

import '../../shared/component/constants.dart';
import '../../features/presentation/page/notification/notificationScreen.dart';
import '../Search/SearchScreen.dart';
import 'LayOutCubit/HayatLayoutCubit.dart';
import 'LayOutCubit/LayoutState.dart';

class HayatLayoutScreen extends StatelessWidget {
  const HayatLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LayoutCubit()..getHomeData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton(
                elevation: .0,
                highlightElevation: .0,
                backgroundColor: Colors.amber,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 55,
                  weight: 555,
                ),
                onPressed: () {},
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              elevation: .0,
              padding: const EdgeInsets.all(0),
              clipBehavior: Clip.hardEdge,
              notchMargin: .5,
              shape: const CircularNotchedRectangle(),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                onTap: (index) {
                  layoutCubit.changIndex(index);
                },
                currentIndex: layoutCubit.currentIndex,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding:
                            EdgeInsets.only(right: size.width / 15, top: 10),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      label: '',
                      activeIcon: Padding(
                        padding:
                            EdgeInsets.only(right: size.width / 15, top: 10),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              color: Colors.amber,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(color: Colors.amber),
                            ),
                          ],
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      activeIcon: Padding(
                        padding:
                            EdgeInsets.only(right: size.width / 10, top: 10),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/hayat_logo.png',
                              cacheWidth: 25,
                              color: Colors.amber,
                            ),
                            const Text(
                              'Donations',
                              style: TextStyle(
                                color: Colors.amber,
                              ),
                            )
                          ],
                        ),
                      ),
                      icon: Padding(
                        padding:
                            EdgeInsets.only(right: size.width / 10, top: 10),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/hayat_logo.png',
                              cacheWidth: 25,
                              color: Colors.grey,
                            ),
                            const Text(
                              'Donations',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding:
                            EdgeInsets.only(left: size.width / 10, top: 10),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              'Needs',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      label: '',
                      activeIcon: Padding(
                        padding:
                            EdgeInsets.only(left: size.width / 10, top: 10),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              color: Colors.amber,
                            ),
                            Text(
                              'Needs',
                              style: TextStyle(color: Colors.amber),
                            )
                          ],
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding:
                            EdgeInsets.only(left: size.width / 10, top: 10),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.person_outline_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      label: '',
                      activeIcon: Padding(
                        padding:
                            EdgeInsets.only(left: size.width / 10, top: 10),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.person_outline_outlined,
                              color: Colors.amber,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(color: Colors.amber),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
            body: layoutCubit.screens[layoutCubit.currentIndex],
          );
        },
      ),
    );
  }
}
