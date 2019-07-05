// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gank_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

gank_news _$gank_newsFromJson(Map<String, dynamic> json) {
  return gank_news(
      json['code'] as int,
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$gank_newsToJson(gank_news instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['type'] as String,
      json['text'] as String,
      json['user_id'] as String,
      json['name'] as String,
      json['screen_name'] as String,
      json['profile_image'] as String,
      json['created_at'] as String,
      json['passtime'] as String,
      json['love'] as String,
      json['hate'] as String,
      json['comment'] as String,
      json['repost'] as String,
      json['bookmark'] as String,
      json['bimageuri'] as String,
      json['status'] as String,
      json['theme_id'] as String,
      json['theme_name'] as String,
      json['theme_type'] as String,
      json['videouri'] as String,
      json['videotime'] as int,
      json['original_pid'] as String,
      json['cache_version'] as int,
      json['playcount'] as String,
      json['playfcount'] as String,
      json['cai'] as String,
      json['image1'] as String,
      json['image2'] as String,
      json['is_gif'] as bool,
      json['image0'] as String,
      json['image_small'] as String,
      json['cdn_img'] as String,
      json['width'] as String,
      json['height'] as String,
      json['tag'] as String,
      json['t'] as int,
      json['ding'] as String,
      json['favourite'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'user_id': instance.userId,
      'name': instance.name,
      'screen_name': instance.screenName,
      'profile_image': instance.profileImage,
      'created_at': instance.createdAt,
      'passtime': instance.passtime,
      'love': instance.love,
      'hate': instance.hate,
      'comment': instance.comment,
      'repost': instance.repost,
      'bookmark': instance.bookmark,
      'bimageuri': instance.bimageuri,
      'status': instance.status,
      'theme_id': instance.themeId,
      'theme_name': instance.themeName,
      'theme_type': instance.themeType,
      'videouri': instance.videouri,
      'videotime': instance.videotime,
      'original_pid': instance.originalPid,
      'cache_version': instance.cacheVersion,
      'playcount': instance.playcount,
      'playfcount': instance.playfcount,
      'cai': instance.cai,
      'image1': instance.image1,
      'image2': instance.image2,
      'is_gif': instance.isGif,
      'image0': instance.image0,
      'image_small': instance.imageSmall,
      'cdn_img': instance.cdnImg,
      'width': instance.width,
      'height': instance.height,
      'tag': instance.tag,
      't': instance.t,
      'ding': instance.ding,
      'favourite': instance.favourite
    };
