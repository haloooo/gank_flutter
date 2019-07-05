import 'package:json_annotation/json_annotation.dart';

part 'gank_news.g.dart';


@JsonSerializable()
class gank_news extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Data> data;

  gank_news(this.code,this.msg,this.data,);

  factory gank_news.fromJson(Map<String, dynamic> srcJson) => _$gank_newsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$gank_newsToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'screen_name')
  String screenName;

  @JsonKey(name: 'profile_image')
  String profileImage;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'passtime')
  String passtime;

  @JsonKey(name: 'love')
  String love;

  @JsonKey(name: 'hate')
  String hate;

  @JsonKey(name: 'comment')
  String comment;

  @JsonKey(name: 'repost')
  String repost;

  @JsonKey(name: 'bookmark')
  String bookmark;

  @JsonKey(name: 'bimageuri')
  String bimageuri;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'theme_id')
  String themeId;

  @JsonKey(name: 'theme_name')
  String themeName;

  @JsonKey(name: 'theme_type')
  String themeType;

  @JsonKey(name: 'videouri')
  String videouri;

  @JsonKey(name: 'videotime')
  int videotime;

  @JsonKey(name: 'original_pid')
  String originalPid;

  @JsonKey(name: 'cache_version')
  int cacheVersion;

  @JsonKey(name: 'playcount')
  String playcount;

  @JsonKey(name: 'playfcount')
  String playfcount;

  @JsonKey(name: 'cai')
  String cai;

  @JsonKey(name: 'image1')
  String image1;

  @JsonKey(name: 'image2')
  String image2;

  @JsonKey(name: 'is_gif')
  bool isGif;

  @JsonKey(name: 'image0')
  String image0;

  @JsonKey(name: 'image_small')
  String imageSmall;

  @JsonKey(name: 'cdn_img')
  String cdnImg;

  @JsonKey(name: 'width')
  String width;

  @JsonKey(name: 'height')
  String height;

  @JsonKey(name: 'tag')
  String tag;

  @JsonKey(name: 't')
  int t;

  @JsonKey(name: 'ding')
  String ding;

  @JsonKey(name: 'favourite')
  String favourite;

  Data(this.type,this.text,this.userId,this.name,this.screenName,this.profileImage,this.createdAt,this.passtime,this.love,this.hate,this.comment,this.repost,this.bookmark,this.bimageuri,this.status,this.themeId,this.themeName,this.themeType,this.videouri,this.videotime,this.originalPid,this.cacheVersion,this.playcount,this.playfcount,this.cai,this.image1,this.image2,this.isGif,this.image0,this.imageSmall,this.cdnImg,this.width,this.height,this.tag,this.t,this.ding,this.favourite,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
