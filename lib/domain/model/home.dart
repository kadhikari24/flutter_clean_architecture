class HomeObject {
  HomeData data;

  HomeObject(this.data);
}

class HomeData {
  List<Service> services;

  List<Banner> banners;

  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class Service {
  int id;

  String title;

  String image;

  Service(this.id, this.title, this.image);
}

class Store {
  int id;

  String title;

  String image;

  Store(this.id, this.title, this.image);
}

class Banner {
  int id;
  String title;
  String image;
  String link;

  Banner(this.id, this.title, this.image, this.link);
}
