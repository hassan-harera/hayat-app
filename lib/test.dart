import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/presentation/page/login/LoginCubit/LoginCubit.dart';
import 'package:hayat_eg/features/presentation/page/login/LoginCubit/LoginStates.dart';
import 'package:hayat_eg/shared/component/component.dart';

class SearchTestScreen extends StatelessWidget {
  SearchTestScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          var list = loginCubit.search;
          return SafeArea(
            child: Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  mySearchTextFormField(
                    onChanged: (value) {
                      // LoginCubit.get(context).getSearch(value);
                    },
                    borderRadius: 50,
                    prefixIcon: (Icons.search),
                    prefixSize: 30,
                    prefixColor: Color(0xff51565F),
                    hint: 'Search Donation',
                    hintColor: Color(0xff848B94),
                    backGroundColor: Color(0xffCED9E9),
                    borderColor: Color(0xffCED9E9),
                    height: 50,
                  ),
                  ListView()
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
