import 'package:json_annotation/json_annotation.dart';

part 'home_store.g.dart';

@JsonSerializable()
class HomeStore {
  HomeStore(
    this.id,
    this.isNew,
    this.title,
    this.subtitle,
    this.pictureUrl,
    this.isBuy,
  );

  int id;
  @JsonKey(name: 'is_new')
  bool isNew;
  String title;
  String subtitle;
  @JsonKey(name: 'picture')
  String pictureUrl;
  @JsonKey(name: 'is_buy')
  bool isBuy;

  factory HomeStore.fromJson(Map<String, dynamic> json) =>
      _$HomeStoreFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStoreToJson(this);
}
