class HomeStore {
  int? id;
  bool? isNew;
  String? title;
  String? subtitle;
  String? picture;
  bool? isBuy;

  HomeStore(
      {this.id,
        this.isNew,
        this.title,
        this.subtitle,
        this.picture,
        this.isBuy});

  HomeStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isNew = json['is_new'];
    title = json['title'];
    subtitle = json['subtitle'];
    picture = json['picture'];
    isBuy = json['is_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_new'] = isNew;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['picture'] = picture;
    data['is_buy'] = isBuy;
    return data;
  }

  @override
  String toString() {
    return 'HomeStore(id: $id, isNew: $isNew , title: $title, '
        'subtitle: $subtitle, picture: $picture, isBuy: $isBuy)';
  }
}





















// import 'package:json_annotation/json_annotation.dart';
//
// part 'home_store.g.dart';
//
// @JsonSerializable()
// class HomeStore {
//   HomeStore(
//     this.id,
//     this.isNew,
//     this.title,
//     this.subtitle,
//     this.pictureUrl,
//     this.isBuy,
//   );
//
//   int id;
//   @JsonKey(name: 'is_new')
//   bool isNew;
//   String title;
//   String subtitle;
//   @JsonKey(name: 'picture')
//   String pictureUrl;
//   @JsonKey(name: 'is_buy')
//   bool isBuy;
//
//   factory HomeStore.fromJson(Map<String, dynamic> json) =>
//       _$HomeStoreFromJson(json);
//
//   Map<String, dynamic> toJson() => _$HomeStoreToJson(this);
//
//   @override
//   String toString() {
//     return 'HomeStore(id: $id, isNew: $isNew , title: $title, '
//         'subtitle: $subtitle, pictureUrl: $pictureUrl, isBuy: $isBuy)';
//   }
// }
