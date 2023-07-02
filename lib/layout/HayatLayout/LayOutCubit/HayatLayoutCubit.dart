import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/features/data/model/HomeModel/HomeModelScreen.dart';
import 'package:hayat_eg/features/presentation/page/need/needs_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/presentation/page/donation/donations_screen.dart';
import '../../../features/presentation/page/home_screen.dart';
import '../../../features/presentation/page/profile/profileScreen.dart';
import '../../../shared/network/endPoints/endPint.dart';
import '../../../shared/network/local/Cash_helper/DioHelper.dart';
import 'LayoutState.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  List<String> unitList = [
    'kg',
    'gr',
    'mg',
  ];

  var key = GlobalKey();
  String? selectedItem = 'kg';
  Uint8List? imageFile;

  Future imageFromGallery(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = image as Uint8List?;

    emit(LayoutChoiceImageFromGalleryState());
    Navigator.pop(context);
  }

  Future imageFromCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    imageFile = image.toString() as Uint8List?;
    emit(LayoutChoiceImageFromCameraState());
    Navigator.pop(key.currentContext ?? context);
  }

  String? communicationTool = 'communication';

  List<Widget> screens = [
    const HomeScreen(),
    DonationsScreen(),
    NeedsScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  void changIndex(int index) {
    currentIndex = index;
    emit(LayoutChangeModeState());
  }

  void changRadioValue() {
    emit(LayoutChangTitleIndexState());
  }

  List<String> titleList = [
    'BOOKS DONATION',
    'FOOD DONATION',
    'MEDICINE DONATION',
    'CLOTHES DONATION',
  ];
  List<String> typeCategory = [
    'BOOKS Category',
    'FOOD Category',
    'MEDICINE Category',
    'CLOTHES Category',
  ];

  void changCategoryTitleToMedicine() {
    emit(LayoutVoidMedicineIndexState());
  }

  void changCategoryTitleToBook() {
    emit(LayoutVoidBookIndexState());
  }

  late HomeModel homeModel;

  void getHomeData() {
    emit(LayoutLoadingState());
    DioHelper.getData(
      url: Home,
      // token:token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(LayoutSuccessState());
    }).catchError((error) {
      emit(LayoutError());
    });
  }
}
