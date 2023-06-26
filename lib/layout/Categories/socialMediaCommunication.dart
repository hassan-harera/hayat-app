
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hayat_eg/layout/LayoutScreens/Donation/DonationScreen.dart';

import '../../services/postRequest/Medicine/postMedicineServices.dart';
import '../../shared/component/constans.dart';

class SocialMediaCommunication extends StatelessWidget {
   SocialMediaCommunication({Key? key, required this.title,required this.quantity, required this.cityId,required this.communicationMethod,required this.description,required this.bookTitle,required this.foodUnitId,required this.foodCategoryId,required this.foodExpirationDate, this.categoryName, this.date,required this.file}) : super(key: key);
final int? quantity;
final int? cityId;
final String? communicationMethod;
final String? description;
final String? categoryName;
final String? title;
final String? date;
late final   Uint8List?  file;
final String? bookTitle;
final int? foodUnitId;
final int? foodCategoryId;
final String? foodExpirationDate;
  var watsAppController =TextEditingController();
  var telegramController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
               title: const Text('Social Communication',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),

      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key:formKey ,
          autovalidateMode: autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Social Media',style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              TextFormField(
                controller: watsAppController,
                keyboardType: TextInputType.phone,
                validator: (v){if(v!.isEmpty){
                  return'please add your watsapp number';
                }},
                decoration: InputDecoration(
                  prefixIcon: Image.asset('assets/watsapp.png',scale:18,color: Colors.amber,),
                    hintText: 'WatsApp',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.amber,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.amber))),
              ),
             const SizedBox(height: 20,),
              TextFormField(
                validator: (v){if(v!.isEmpty){
                  return'please add your telegram number';
                }},
                controller: telegramController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.telegram_outlined,color: Colors.amber,size: 35,),

                    hintText: 'Telegram',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.amber,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.amber))),
              ),
             const Spacer(),
              myButton(text: 'ADD',onTap: (){

                if(formKey.currentState!.validate()) {

                  myNavigator(context, DonationScreen(donationBuilder:itemBuilder(categoryName: categoryName,description: description, date:date,file:file , ) ,));
                }
              },radius: 10),
            ],
          ),
        ),
      ) ,
    );
  }
}
