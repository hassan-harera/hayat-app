//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class GroupModel {
//   String text;
//   int index;
//   bool selected;
//
//   GroupModel({required this.text,required this.index,required this.selected});
// }
//
//
// class MyApp extends StatefulWidget {
//   @override
//   _State createState() => new _State();
// }
//
// class _State extends State<MyApp> {
//   int _value2 = 0;
//   List<GroupModel> _group = [
//     GroupModel(text: "Andorid", index: 1, selected: true),
//     GroupModel(text: "IOS", index: 2, selected: false),
//     GroupModel(text: "Flutter", index: 3, selected: false),
//   ];
//
//   // Widget makeRadioTiles() {
//   //
//   //
//   //   for (int i = 0; i < _group.length; i++) {
//   //     list.add(new RadioListTile(
//   //       value: _group[i].index,
//   //       groupValue: _value2,
//   //       selected: _group[i].selected,
//   //       onChanged: (val) {
//   //         setState(() {
//   //           for (int i = 0; i < _group.length; i++) {
//   //             _group[i].selected = false;
//   //           }
//   //           _value2 = val!;
//   //           _group[i].selected = true;
//   //         });
//   //       },
//   //       activeColor: Colors.purple,
//   //       controlAffinity: ListTileControlAffinity.trailing,
//   //       title: new Text(
//   //         ' ${_group[i].text}',
//   //         style: TextStyle(
//   //             color: _group[i].selected ? Colors.black : Colors.grey,
//   //             fontWeight:
//   //             _group[i].selected ? FontWeight.bold : FontWeight.normal),
//   //       ),
//   //     ));
//   //   }
//   //
//   //   Column column = new Column(
//   //     children: list,
//   //   );
//   //   return column;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('RadioListTile Demo'),
//       ),
//       //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
//       body: new Container(
//         padding: new EdgeInsets.all(32.0),
//         child: new Center(
//           child: new Column(
//             children: <Widget>[makeRadioTiles()],
//           ),
//         ),
//       ),
//     );
//   }
// }
