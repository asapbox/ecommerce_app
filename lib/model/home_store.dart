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
    id = json['id'] as int;
    isNew = json['is_new'] ?? false;
    title = json['title'] as String;
    subtitle = json['subtitle'] as String;
    picture = json['picture'] as String;
    isBuy = json['is_buy'] as bool;
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