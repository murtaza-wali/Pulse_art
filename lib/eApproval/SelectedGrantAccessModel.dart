class CheckBoxListTileModel {
  int userId;
  String img;
  String title;
  bool isCheck;

  CheckBoxListTileModel({this.userId, this.img, this.title, this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          userId: 1,
          img: 'assets/images/user.png',
          title: "Concurrent Manager Access",
          isCheck: true),
      CheckBoxListTileModel(
          userId: 2,
          img: 'assets/images/user.jpeg',
          title: "Journal Batch",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 3,
          img: 'assets/images/user.webp',
          title: "PO Approval",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 4,
          img: 'assets/images/user.png',
          title: "Procurement Processes",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 5,
          img: 'assets/images/user.png',
          title: "Requistion",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 5,
          img: 'assets/images/user.png',
          title: "System: Tests",
          isCheck: false),
    ];
  }
}