import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/features/data/model/need/need_response.dart';
import 'package:hayat_eg/features/presentation/widgets/need/book_need_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_tab_item.dart';

import '../../../../shared/component/component.dart';
import '../../../../shared/component/constants.dart';
import '../notification/notificationScreen.dart';

// class NeedsScreen extends StatelessWidget {
//   List<NeedResponse> _list = [];
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                       child: mySearchTextFormField(
//                           borderRadius: 50,
//                           prefixIcon: (Icons.search),
//                           prefixSize: 30,
//                           prefixColor: Color(0xff51565F),
//                           hint: 'Search Needs',
//                           hintColor: Color(0xff848B94),
//                           backGroundColor: Color(0xffCED9E9),
//                           borderColor: Color(0xffCED9E9),
//                           height: 50)),
//                   SizedBox(
//                     width: size.width / 40,
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       myNavigator(context, notificationScreen());
//                     },
//                     icon: const Icon(
//                       Icons.notifications,
//                       size: 33,
//                     ),
//                     color: Color(0xff20ADDC),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                   child: ListView.builder(
//                       padding: EdgeInsets.all(0),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) => Padding(
//                             padding: EdgeInsets.only(
//                               bottom: size.height / 30,
//                             ),
//                             child: needItem(
//                               context,
//                               _list[index],
//                             ),
//                           ),
//                       itemCount: _list.length)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class NeedsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  List<BookNeedResponse> _list = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Needs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters'),
                Text('Sort'),
              ],
            ),
          ),
          Container(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TabItem(text: 'All'),
                TabItem(text: 'Medicines'),
                TabItem(text: 'Books'),
                TabItem(text: 'Blood'),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: size.height / 30,
                        ),
                        child: bookNeedItem(
                          context,
                          _list[index],
                        ),
                      ),
                  itemCount: _list.length)),
        ],
      ),
    );
  }
}
