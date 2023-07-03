import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/features/presentation/widgets/need/book_need_item.dart';
import 'package:hayat_eg/features/presentation/widgets/need/need_tab_item.dart';

class BookNeedsScreen extends StatefulWidget {
  const BookNeedsScreen({super.key});

  @override
  State<BookNeedsScreen> createState() => _BookNeedsScreenState();
}

class _BookNeedsScreenState extends State<BookNeedsScreen> {
  final formKey = GlobalKey<FormState>();
  final List<BookNeedResponse> _list = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters'),
                Text('Sort'),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                TabItem(text: 'All'),
                TabItem(text: 'Medicines'),
                TabItem(text: 'Books'),
                TabItem(text: 'Blood'),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
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
