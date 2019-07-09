import 'package:flutter/material.dart';
import 'package:gank_flutter/utils/API.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/model/gank_news.dart';
import 'package:video_player/video_player.dart';
import 'package:gank_flutter/picture/video_item.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class PicturePage extends StatefulWidget {

  @override
  State<PicturePage> createState() => new _PicturePageState();
}

class _PicturePageState extends State<PicturePage> with TickerProviderStateMixin{
  List<Data> _gankItems = [];
  int offset = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadNewsData();
    fluwx.register(appId:"wxd930ea5d5a258f4f");
    _scrollController = ScrollController()..addListener(() {});
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        offset += 1;
        _loadNewsData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    for(var item in _gankItems){
      videoPlayerController(item.videouri).dispose();
    }
  }

  VideoPlayerController videoPlayerController(url){
    VideoPlayerController videoPlayerController = VideoPlayerController.network(url);
    return videoPlayerController;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('图片'),
        ),
        body: Container(
          child:
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: _gankItems.length > 0 ? ListView.builder(
                itemCount: _gankItems.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    width: MediaQuery.of(context).size.width,
//                  height: 400,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width:50,
                                height: 50,
                                child: ClipOval(
                                  child: Image.network(_gankItems[index].profileImage),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(_gankItems[index].name),
                                  Text(_gankItems[index].createdAt),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(_gankItems[index].text),
                        ),
//                      Chewie(
//                        controller: ChewieController(
//                          videoPlayerController: videoPlayerController(_gankItems[index].videouri),
//                          aspectRatio: 1,
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
//                          autoPlay: false,
//                          looping: true,
//                          showControls: true,
//                          autoInitialize: true,
//                        ),
//                      )

                        GestureDetector(
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              image: new DecorationImage(image: new NetworkImage(_gankItems[index].cdnImg), fit: BoxFit.cover),
                              shape: BoxShape.rectangle,              // <-- 这里需要设置为 rectangle
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0),        // <-- rectangle 时，BorderRadius 才有效
                              ),
                            ),
                            height: 200,
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new VideoItem(videoUri: _gankItems[index].videouri)),
                            );
                          },
                        ),

                        Row(
                          children: <Widget>[
                            Icon(Icons.sentiment_dissatisfied),
                            Text(" " + _gankItems[index].cai + " "),
                            Icon(Icons.sentiment_satisfied),
                            Text(" " + _gankItems[index].favourite),
                            FlatButton(
                                onPressed: () {
                                  fluwx.share(
                                      fluwx.WeChatShareWebPageModel(
                                        webPage: "https://github.com/JarvanMo/fluwx",
                                        title: "Fluwx",
                                        thumbnail: "http://d.hiphotos.baidu.com/image/h%3D300/sign=1057e22c6ed9f2d33f1122ef99ee8a53/3bf33a87e950352aadfff8c55f43fbf2b3118b65.jpg",
                                      )).then((result){
                                    print(result);
                                  },
                                      onError: (msg){
                                        print(msg);
                                      });

                                },
                                child: new Text("分享"))

                          ],
                        )
                      ],
                    ),
                  );
                }
            ): Center(child: CircularProgressIndicator()),
          )
        ),
      ),
    );
  }

  _loadNewsData() async{
    Dio dio = new Dio();
    Response response=await dio.get(GankApi.API_GANK_NEWS+"$offset");
    if(response.statusCode == 200){
      setState(() {
        var house = new gank_news.fromJson(response.data);
        if(offset == 1){
          _gankItems = house.data;
        }else{
          _gankItems.addAll(house.data);
        }
      });
    }
  }

  Future<Null> _onRefresh() async {
    offset = 1;
    _loadNewsData();
    return null;
  }
}