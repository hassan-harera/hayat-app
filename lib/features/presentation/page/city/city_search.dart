import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hayat_eg/injection_container.dart';

import '../../../data/model/city/city.dart';
import '../../../data/repository/CityRepository.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<City>? _results = [];
  CityRepository cityRepository = sl();

  void _search(String query) async {
    List<City>? result = await cityRepository.search(query);
    setState(() {
      _results = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: _search,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _results?.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(_results?[index].englishName ?? ''),
              onTap: () {
                _results?[index].id;
                Navigator.pop(context, _results?[index]);
              });
        },
      ),
    );
  }
}
