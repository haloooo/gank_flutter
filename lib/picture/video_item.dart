import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gank_flutter/utils/API.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/model/gank_news.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoItem extends StatefulWidget {
  final String videoUri;


  VideoItem({Key key, @required this.videoUri}) : super(key: key);


  @override
  State<VideoItem> createState() => new _VideoItemState();
}

class _VideoItemState extends State<VideoItem> with TickerProviderStateMixin{

  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUri);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('图片'),
        ),
        body: Container(
            child:Chewie(
              controller: ChewieController(
                videoPlayerController: videoPlayerController,
                aspectRatio: 1,
//                          placeholder: Container(
//                            decoration: new BoxDecoration(
//                              color: Colors.white,
//                              image: new DecorationImage(image: new NetworkImage(_gankItems[index].cdnImg), fit: BoxFit.cover),
//                              shape: BoxShape.rectangle,              // <-- 这里需要设置为 rectangle
//                              borderRadius: new BorderRadius.all(
//                                const Radius.circular(20.0),        // <-- rectangle 时，BorderRadius 才有效
//                              ),
//                            ),
//                          ),
                autoPlay: true,
                looping: true,
                showControls: true,
                autoInitialize: true,
              ),
            )
        )
    );
  }


}