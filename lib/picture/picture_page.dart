import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gank_flutter/utils/API.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/model/gank_news.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PicturePage extends StatefulWidget {

  @override
  State<PicturePage> createState() => new _PicturePageState();
}

class _PicturePageState extends State<PicturePage> with TickerProviderStateMixin{
  List<Data> _gankItems = [];


  @override
  void initState() {
    super.initState();
    _loadNewsData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('图片'),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: _gankItems.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  child: Column(
                    children: <Widget>[
                      Chewie(
                        controller: ChewieController(
                          videoPlayerController: VideoPlayerController.network(_gankItems[index].videouri),
                          aspectRatio: 1,
                          autoPlay: false,
                          looping: false,
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  _loadNewsData() async{
    Dio dio = new Dio();
    Response response=await dio.get(GankApi.API_GANK_NEWS);
    if(response.statusCode == 200){
      setState(() {
        var house = new gank_news.fromJson(response.data);
        _gankItems = house.data;
      });
    }
  }
}