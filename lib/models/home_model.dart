class ProductModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final bool inFavourite;
  final bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavourite,
    required this.inCart,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      inFavourite: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}

class BannerModel {
  final int id;
  final String image;

  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
    );
  }
}

class DataModel {
  List<BannerModel> banner = [];
  List<ProductModel> product = [];

  DataModel({required this.banner, required this.product});

  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banner.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      product.add(ProductModel.fromJson(element));
    });
  }
}

class HomeModel {
  final bool status;
  final DataModel data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(status: json['status'], data: DataModel.fromJson(json['data']));
  }
}
