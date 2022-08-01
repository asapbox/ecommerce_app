class BestSeller {
  int? id;
  bool? isFavorites;
  String? title;
  int? priceWithoutDiscount;
  int? discountPrice;
  String? picture;

  BestSeller(
      {this.id,
      this.isFavorites,
      this.title,
      this.priceWithoutDiscount,
      this.discountPrice,
      this.picture});

  BestSeller.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    isFavorites = json['is_favorites'] as bool;
    title = json['title'] as String;
    priceWithoutDiscount = json['price_without_discount'] as int;
    discountPrice = json['discount_price'] as int;
    picture = json['picture'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_favorites'] = isFavorites;
    data['title'] = title;
    data['price_without_discount'] = priceWithoutDiscount;
    data['discount_price'] = discountPrice;
    data['picture'] = picture;
    return data;
  }

  @override
  String toString() {
    return 'BestSeller(id: $id, isFavorites: $isFavorites, title: $title, '
        'priceWithoutDiscount: $priceWithoutDiscount, '
        'discountPrice: $discountPrice, picture: $picture)\n';
  }
}
