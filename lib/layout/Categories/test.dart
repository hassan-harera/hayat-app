// import 'package:path/path.dart';
// import 'package:async/async.dart';
// import 'dart:io';
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart'as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hayat_eg/layout/HayatLayout/hayat-egLayout.dart';
// import 'package:hayat_eg/shared/Utils/Utils.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import '../../shared/component/component.dart';
// import '../../shared/component/constans.dart';
// import '../HayatLayout/LayOutCubit/HayatLaoutCubit.dart';
// import '../HayatLayout/LayOutCubit/LayoutState.dart';
//
// class TestCategoryScreen extends StatefulWidget {
//   const TestCategoryScreen({super.key});
//
//   @override
//   State<TestCategoryScreen> createState() => _TestCategoryScreenState();
// }
//
// class _TestCategoryScreenState extends State<TestCategoryScreen> {
//   final formKey = GlobalKey<FormState>();
//
//   var descriptionController=TextEditingController();
//   AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
//
//   _selectImage(BuildContext context) async {
//     final size = MediaQuery.of(context).size;
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return SimpleDialog(
//           title: const Text('Create post '),
//           children: [
//             SimpleDialogOption(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.camera,
//                     color: Colors.amber,
//                   ),
//                   SizedBox(
//                     width: size.width / 30,
//                   ),
//                   const Text(
//                     'Take a photo from camera',
//                   ),
//                 ],
//               ),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 final pickedFile = await pickImage(ImageSource.camera);
//                 if(pickedFile==null){
//                   image = File(pickedFile.path);
//                   setState(() {
//
//                   });
//                 }
//
//               },
//             ),
//             SimpleDialogOption(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   const Icon(Icons.image),
//                   SizedBox(
//                     width: size.width / 30,
//                   ),
//                   const Text('chose from gallery '),
//                 ],
//               ),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//
//                 final pickedFile = await pickImage(ImageSource.gallery);
//                 if(pickedFile !=null){
//                   setState(() {
//                     image = File(pickedFile.path);
//                   });
//                 }
//
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//   File? image;
//   bool showSpinner= false;
// Future<void>uploadImage ()async{
//     setState(() {
//       showSpinner=true;
//     });
// var stream= new http.ByteStream(image!.openRead());
// stream.cast();
// var length = await image!.length();
// var uri =Uri.parse('http://64.225.6.213:8080/api/v1/donations/clothing/2/images');
// var request=new http.MultipartRequest('POST', uri);
//
// request.fields['title']="static title";
// var multiPort=new http.MultipartFile('image',
//     stream,
//     length);
// request.files.add(multiPort);
// var response =await request.send();
// if(response.statusCode==200){
//   setState(() {
//     showSpinner=false;
//   });
//   print('image uploaded') ;
// }else{
//   print('field to upload image ') ;
// }
//
// }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BlocProvider(
//       create: (context) => LayoutCubit(),
//       child: BlocConsumer<LayoutCubit, LayoutStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           LayoutCubit layoutCubit = LayoutCubit.get(context);
//           final size = MediaQuery.of(context).size;
//           // final User user =Provider.of<UserProvider>(context);
//           return ModalProgressHUD(
//             inAsyncCall:showSpinner,
//             child: GestureDetector(
//               onTap: (){
//                 FocusScope.of(context).unfocus();
//               },
//               child: Scaffold(
//                   appBar: AppBar(
//                     title: const Text(
//                       'Test Category ',
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                     ),
//                   ),
//                   body: SafeArea(
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Form(
//                           autovalidateMode: autoValidateMode,
//                           key: formKey,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () => _selectImage(context),
//                                     child: image == null
//                                         ? Image.asset(
//                                       'assets/add-image.png',
//                                       width: 100,
//                                       height: 100,
//                                     )
//                                         : Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: SizedBox(
//                                         width: 100,
//                                         height: 100,
//                                         child: AspectRatio(
//                                           aspectRatio: 478 / 451,
//                                           child: Container(
//                                             padding: const EdgeInsets.only(top:10,bottom: 10,right: 10),
//                                             decoration: BoxDecoration(
//
//                                                 borderRadius:
//                                                 BorderRadius.circular(10),
//
//                                             ),
//                                             child: Image.file(
//                                               File(image!.path).absolute,
//                                               height: 100,
//                                               width: 100,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // const Spacer(),
//                                   myStaticTextFormField(
//                                     width: size.width - 160,
//                                     hint: 'Title',
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'please add Title';
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               myDescriptionTextFormField(controller: descriptionController),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               myStaticTextFormField(
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'please add Test Category';
//                                   }
//                                 },
//                                 hint: 'Test Category',
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               myStaticTextFormField(
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please inter Test Language';
//                                   }
//                                 },
//                                 hint: 'Test Language',
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               myStaticTextFormField(
//                                 hint: 'publisher',
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please inter publisher';
//                                   }
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               const Text(
//                                 'Communication Method',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                       value: 'Chat',
//                                       groupValue: layoutCubit.communicationTool,
//                                       onChanged: (value) {
//                                         layoutCubit.communicationTool = value;
//                                         layoutCubit.changRadioValue();
//                                         //   setState(() {});
//                                       }),
//                                   const Text(
//                                     'chat',
//                                     style: TextStyle(fontSize: 17),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                       value: 'Phone',
//                                       groupValue: layoutCubit.communicationTool,
//                                       onChanged: (value) {
//                                         layoutCubit.communicationTool = value;
//                                         layoutCubit.changRadioValue();
//                                         //  setState(() {});
//                                       }),
//                                   const Text(
//                                     'Phone',
//                                     style: TextStyle(fontSize: 17),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                       value: 'Phone-chat',
//                                       groupValue: layoutCubit.communicationTool,
//                                       onChanged: (value) {
//                                         layoutCubit.communicationTool = value;
//                                         layoutCubit.changRadioValue();
//                                         //   setState(() {});
//                                       }),
//                                   const Text(
//                                     'Phone-chat',
//                                     style: TextStyle(fontSize: 17),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               myButton(
//                                   text: 'Next',
//                                   onTap: () async {
//                                     if (formKey.currentState!.validate()) {
//                                       formKey.currentState!.save();
//
//
//                                       myNavigator(context,
//                                           const HayatLayoutScreen());
//                                     }else{
//                                       setState(() {
//
//                                       });
//                                       autoValidateMode=AutovalidateMode.always;
//                                     }
//                                     //
//                                   },
//                                   radius: 10),
//                               myButton(
//                                   text: 'upload',
//                                   onTap: () async {
//                                   uploadImage();
//                                   },
//                                   radius: 10),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   )),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// upload(File imageFile) async {
//   // open a bytestream
//   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//   // get file length
//   var length = await imageFile.length();
//
//   // string to uri
//   var uri = Uri.parse("http://ip:8082/composer/predict");
//
//   // create multipart request
//   var request = new http.MultipartRequest("POST", uri);
//
//   // multipart that takes file
//   var multipartFile = new http.MultipartFile('file', stream, length,
//       filename: basename(imageFile.path));
//
//   // add file to multipart
//   request.files.add(multipartFile);
//
//   // send
//   var response = await request.send();
//   print(response.statusCode);
//
//   // listen for response
//   response.stream.transform(utf8.decoder).listen((value) {
//     print(value);
//   });
// }
// // void onTakePictureButtonPressed() {
// //   takePicture().then((String filePath) {
// //     if (mounted) {
// //       setState(() {
// //         imagePath = filePath;
// //         videoController?.dispose();
// //         videoController = null;
// //       });
// //
// //       // initiate file upload
// //       Upload(File(filePath));
// //
// //       if (filePath != null) showInSnackBar('Picture saved to $filePath');
// //     }
// //   });
// // }
