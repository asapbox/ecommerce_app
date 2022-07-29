// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStore _$HomeStoreFromJson(Map<String, dynamic> json) => HomeStore(
      json['id'] as int,
      json['is_new'] as bool,
      json['title'] as String,
      json['subtitle'] as String,
      json['picture'] as String,
      json['is_buy'] as bool,
    );

Map<String, dynamic> _$HomeStoreToJson(HomeStore instance) => <String, dynamic>{
      'id': instance.id,
      'is_new': instance.isNew,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'picture': instance.pictureUrl,
      'is_buy': instance.isBuy,
    };
