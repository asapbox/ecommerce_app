class Basket {
  int? id;
  String? images;
  int? price;
  String? title;

  Basket({this.id, this.images, this.price, this.title});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    price = json['price'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images;
    data['price'] = price;
    data['title'] = title;
    return data;
  }
}