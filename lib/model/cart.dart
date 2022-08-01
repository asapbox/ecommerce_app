import 'basket.dart';

class Cart {
  List<Basket>? basket;
  String? delivery;
  String? id;
  int? total;

  Cart({this.basket, this.delivery, this.id, this.total});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['basket'] != null) {
      basket = <Basket>[];
      json['basket'].forEach((v) {
        basket!.add(Basket.fromJson(v));
      });
    }
    delivery = json['delivery'];
    id = json['id'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (basket != null) {
      data['basket'] = basket!.map((v) => v.toJson()).toList();
    }
    data['delivery'] = delivery;
    data['id'] = id;
    data['total'] = total;
    return data;
  }
}


