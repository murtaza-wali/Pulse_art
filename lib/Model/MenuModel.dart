class MenuModel {
  String image = "";
  String title = "";


  MenuModel(String image, String title) {
    this.image = image;
    this.title = title;
  }

  List<MenuModel> loadCategories() {
    var menu = <MenuModel>[
      //adding all the categories of news in the list
      new MenuModel('assets/images/eapprovals.png', "E-Approval"),
      new MenuModel('assets/images/gatekeep_logo.png', "GatePass"),
      new MenuModel('assets/images/denim.png', "Denim"),
      new MenuModel('assets/images/jarvis.png', "J.A.R.V.I.S"),
      new MenuModel('assets/images/tcrm.png', "Tex CRM"),
      new MenuModel('assets/images/isupplier.png', "Supply Chain"),
      new MenuModel('assets/images/denimcosting.png', "Fabric Precosting"),
      new MenuModel('assets/images/dam.png', "DAM")
    ];
    return menu;
  }
}
