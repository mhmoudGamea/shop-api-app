class SearchModel {
  final bool status;
  final Data data;

  SearchModel({required this.status, required this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(status: json['status'], data: Data.fromJson(json['data']));
  }
}

class Data {
  dynamic currentPage;
  List<Product> searchProducts = [];
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
      required this.searchProducts,
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
      searchProducts.add(Product.fromJson(element));
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

class Product {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final String image;
  final String name;
  final String description;

  Product(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.image,
      required this.name,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        image: json['image'],
        name: json['name'],
        description: json['description']);
  }
}
