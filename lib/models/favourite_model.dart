class FavouriteModel {
  final bool status;
  final Data data;

  FavouriteModel({required this.status, required this.data});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(status: json['status'], data: Data.fromJson(json['data']));
  }
}

class Data {
  dynamic currentPage;
  List<FavouriteData> favData = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      required this.favData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      favData.add(FavouriteData.fromJson(element));
    });

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class FavouriteData {
  dynamic id;
  late Product product;

  FavouriteData({required this.id, required this.product});

  factory FavouriteData.fromJson(Map<String, dynamic> json) {
    return FavouriteData(id: json['id'], product: Product.fromJson(json['product']));
  }
}

class Product {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;

  Product(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        description: json['description']);
  }
}
