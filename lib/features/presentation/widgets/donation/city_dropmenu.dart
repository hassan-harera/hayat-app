import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/city/city.dart';

class CitiesDropMenu extends StatelessWidget {
  final List<City> cities;
  final Function(String) onSelectedCity;

  const CitiesDropMenu(
      {super.key, required this.cities, required this.onSelectedCity});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          isFilterOnline: true,
          fit: FlexFit.loose,
          showSelectedItems: true,
          showSearchBox: true,
          menuProps: MenuProps(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          favoriteItemProps: FavoriteItemProps(
            showFavoriteItems: true,
          ),
        ),
        items: cities.map((e) => e.arabicName).toList(),
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.white,
                )),
            border: OutlineInputBorder(
              gapPadding: 10,
            ),
            hintText: "Select city",
          ),
        ),
        onChanged: (value) {
          onSelectedCity(value ?? '');
        },
        validator: (String? item) {
          if (item == null) {
            return "City is Required";
          } else {
            return null;
          }
        });
  }
}
