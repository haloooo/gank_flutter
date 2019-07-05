import 'package:flutter/material.dart';
import 'package:gank_flutter/utils/API.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/classify/classify_item_page.dart';

class ClassifyPage extends StatefulWidget {

  @override
  State<ClassifyPage> createState() => new _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> with TickerProviderStateMixin{
  List tabItems = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadTabsData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
              fit: BoxFit.cover,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
            appBar: AppBar(
              backgroundColor: Colors.transparent, //把appbar的背景色改成透明
              // elevation: 0,//appbar的阴影
              title: Text('分类'),
            ),
            body: tabItems.length > 0 ? Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      labelPadding: EdgeInsets.all(10),
                      indicatorPadding: EdgeInsets.all(5),
                      tabs: tabItems.map((items) {
                        return Text(
                          items['name'],
                        );
                      }).toList()),
                ),
                Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: tabItems.map((items) {
                          return new ClassifyItemPage(enName: items['en_name']);
                        }).toList()
                    )
                )
              ],
            ): Center(
                child: CircularProgressIndicator()),
        )
    );
  }

  _loadTabsData() async{
    Dio dio = new Dio();
    Response response=await dio.get(GankApi.API_CATEGORIES);
    if(response.statusCode == 200){
      setState(() {
        tabItems = response.data['results'];
        _tabController = new TabController(length: tabItems.length, vsync: this);
      });
    }
  }

}