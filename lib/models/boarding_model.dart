class BoardingModel {
  final String image;
  final String title0;
  final String title1;
  final String body;

  BoardingModel({
    required this.image,
    required this.title0,
    required this.title1,
    required this.body,
  });

  static List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/onboard_0.webp',
        title0: 'Sales and ',
        title1: 'Gifts',
        body: 'Holiday sales, Birthday gifts, Various choice and categories.'),
    BoardingModel(
        image: 'assets/images/onboard_1.webp',
        title0: 'Sale & ',
        title1: 'Online shopping',
        body: 'Make an order sitting on sofa. Pay and choose online.'),
    BoardingModel(
        image: 'assets/images/onboard_2.webp',
        title0: 'Open ',
        title1: '24 Hour',
        body: 'Yes, we are open for 24 hour, to produce a high quality service for you'),
  ];
}
