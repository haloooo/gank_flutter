import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gank_flutter/utils/API.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/model/gank_item.dart';
import 'package:gank_flutter/model/gank_post.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/utils/webview_page.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  SwiperController _swiperController;
  List _swiperData = List();
  List<GankItem> _gankItems;
  List _category = [];
  var dataObj;

  @override
  void initState() {
    super.initState();
    _loadSwiperData();
    _loadItemData('today');
    _swiperController = new SwiperController();
    _swiperController.startAutoplay();
  }

  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('首页'),
            leading: IconButton(
              icon: Icon(Icons.date_range),
              onPressed: (){
                showDatePicker(
                  context: context,
                  initialDate: new DateTime.now(),
                  firstDate: new DateTime.now().subtract(new Duration(days: 2000)), // 减 30 天
                  lastDate: new DateTime.now().add(new Duration(days: 30)),       // 加 30 天
                ).then((DateTime val) {
                  String date = '';
                  date = val.year.toString() + '/' + val.month.toString() + '/' + val.day.toString();
                  _loadItemData(date);
                }).catchError((err) {
                  print(err);
                });
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Swiper(
                  itemBuilder: _swiperBuilder,
                  itemCount: _swiperData.length,
                  pagination: new SwiperPagination(
                      builder: FractionPaginationBuilder(
                          color: Colors.white,
                          activeColor: Colors.redAccent,
                          activeFontSize: 40
                      )
                  ),
                  control: new SwiperControl(),
                  controller: _swiperController,
                  scrollDirection: Axis.horizontal,
                  autoplay: false,
                  loop: false,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  onTap: (index) => print('点击了第$index个'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: RefreshIndicator(
                    child: ListView(
                      children: _loadCategoryList(),
                    ),
                    onRefresh: _onRefresh,
                ),
              )
            ],
          )
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      _swiperData[index]['url'],
      fit: BoxFit.fill,
    ));
  }

  List<Widget> _loadCategoryList(){
    List<Widget> _itemList = List();
    for(var categoryItem in _category){
      _itemList.add(
          ExpansionTile(
            title: Text(categoryItem),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
            children: _loadChildrenList(categoryItem),
          )
      );
    }
    return _itemList;
  }

  List<Widget> _loadChildrenList(categoryItem){
    List<Widget> _itemList = List();
    if(_gankItems.length > 0 ){
      for(var item in _gankItems){
        if(item.type == categoryItem && item.isTitle != true){
          _itemList.add(Container(
            decoration: BoxDecoration(
              color: Colors.white,
//              border: Border.all(color: Color(0xFFFF0000), width: 0.5),
                boxShadow: [BoxShadow(color: Color(0x99FFFF00), offset: Offset(5.0, 5.0),    blurRadius: 10.0, spreadRadius: 2.0), BoxShadow(color: Color(0x9900FF00), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0xFF0000FF))],
            ),
            padding: new EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) {
                      return new WebViewPage(
                        title: item.desc,
                        url: item.url,
                      );
                    }
                ));
              },
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text(item.desc),
                        ),
                        item.images.length > 0?
                        Container(
                            height:100,
                            width: MediaQuery.of(context).size.width/2.4,
                            padding: EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
//                                      border: new Border.all(width: 2.0, color: Colors.red),
//                                      color: Colors.grey,
                              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                              image: new DecorationImage(
                                image: new NetworkImage(item.images[0]),
//                                      centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                              ),
                            )
                        ) : Container()
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Icon(Icons.supervised_user_circle),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(item.who),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Icon(Icons.timer),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(item.publishedAt.toString().split('T')[0]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )
          ));
        }
      }
    }
    return _itemList;
  }

  _loadSwiperData() async{
    Dio dio = new Dio();
    Response response=await dio.get(GankApi.API_GANK_PICTURE+'10');
    if(response.statusCode == 200){
      setState(() {
        _swiperData = response.data['results'];
      });
    }
  }

  _loadItemData(String date) async{

    List<dynamic> _category_all  = [];
    Dio dio = new Dio();
    Response response;
    if(date == 'today'){
      response=await dio.get(GankApi.API_GANK_TODAY);
    }else{
      response=await dio.get(GankApi.API_GANK_DAY + date);
    }

    if(response.statusCode == 200){
      _category_all = response.data['category'];
      if(_category_all.length == 0){
        Fluttertoast.showToast(
            msg: "没有数据哦",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.black
        );

        setState(() {
          _category = [];
          _gankItems = [];
        });

      }else{
        var todayItem = GankPost.fromJson(response.data);
        setState(() {
          _category = [];
          _gankItems = todayItem.gankItems;
          for(var item in _gankItems){
            if(item.isTitle){
              _category.add(item.category);
            }
          }
        });
      }
    }
  }

  Future<Null> _onRefresh() async{
    _loadItemData('today');
  }

}