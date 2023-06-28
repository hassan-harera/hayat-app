class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<productModel> products = [];
  List<BannerModel> banners = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(element);
    });
    json['products'].forEach((element) {
      products.add(element);
    });
  }
}

class BannerModel {
  int? id;

  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productModel {
  late int id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  late String? name;
  bool? in_favorites;
  bool? in_cart;

  productModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    old_price = json['old_price'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
