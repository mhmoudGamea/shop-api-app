class CategoryDataModel {
  final dynamic id;
  final String name;
  final String image;

  CategoryDataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(id: json['id'], name: json['name'], image: json['image']);
  }
}

class CategoryData {
  dynamic currentPage;
  List<CategoryDataModel> data = [];

  CategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element)  {
      data.add(CategoryDataModel.fromJson(element));
    });
  }
}

class CategoryModel {
  final bool status;
  final CategoryData cData;

  CategoryModel({required this.status, required this.cData});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(status: json['status'], cData: CategoryData.fromJson(json['data']));
  }
}