class Item {
  String? cPU;
  String? camera;
  List<String>? capacity;
  List<String>? colors;
  String? id;
  List<String>? images;
  bool? isFavorites;
  int? price;
  double? rating;
  String? sd;
  String? ssd;
  String? title;

  Item(
      {this.cPU,
        this.camera,
        this.capacity,
        this.colors,
        this.id,
        this.images,
        this.isFavorites,
        this.price,
        this.rating,
        this.sd,
        this.ssd,
        this.title});

  Item.fromJson(Map<String, dynamic> json) {
    cPU = json['CPU'] as String;
    camera = json['camera'] as String;
    capacity = json['capacity'].cast<String>() as List<String>;
    colors = json['color'].cast<String>() as List<String>;
    id = json['id'] as String;
    images = json['images'].cast<String>() as List<String>;
    isFavorites = json['isFavorites'] as bool;
    price = json['price'] as int;
    rating = json['rating'] as double;
    sd = json['sd'] as String;
    ssd = json['ssd'] as String;
    title = json['title'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['CPU'] = cPU;
    data['camera'] = camera;
    data['capacity'] = capacity;
    data['color'] = colors;
    data['id'] = id;
    data['images'] = images;
    data['isFavorites'] = isFavorites;
    data['price'] = price;
    data['rating'] = rating;
    data['sd'] = sd;
    data['ssd'] = ssd;
    data['title'] = title;
    return data;
  }
}
