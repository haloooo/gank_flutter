import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/utils/API.dart';
import 'package:gank_flutter/classify/classify_item_detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gank_flutter/classify/classify_card_detail.dart';

class ClassifyItemPage extends StatefulWidget {
  final String enName;
  const ClassifyItemPage({Key key, this.enName}) : super(key: key);
  @override
  State<ClassifyItemPage> createState() => new _ClassifyItemPageState();
}

class _ClassifyItemPageState extends State<ClassifyItemPage> with TickerProviderStateMixin{
  List itemList = [];
  int offset = 0;

  @override
  void initState() {
    super.initState();
    _loadItemPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Wrap(
              children: _getIconList(itemList),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: itemList.length > 0 ?
            ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index){
                  return ClassifyItemDetail(articleItem: itemList[index], index: index,);
                }
            ) : Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
//    return Row(
//      children: <Widget>[
//        Container(
//          child: itemList.length > 0 ?
//          ListView.builder(
//              padding: EdgeInsets.all(8.0),
//              itemCount: itemList.length,
//              itemBuilder: (BuildContext context, int index){
//                return ClassifyCard(articleItem: itemList[index], index: index,);
//              }
//          ) : Center(child: CircularProgressIndicator()),
//        )
//      ],
//    );
  }


  _loadItemPage() async{
    Dio dio = new Dio();
    String url = GankApi.API_CATEGORY+"/${widget.enName}";
    Response response=await dio.get(url);
    if(response.statusCode == 200){
      setState(() {
        itemList = response.data['results'];
      });
    }
  }

  List<Widget> _getIconList(itemList){
    List<Widget> list = List();
    for(var item in itemList){
      list.add(
          Container(
//            margin: const EdgeInsets.only(right: 6.0),
//            width: MediaQuery.of(context).size.width / 10,
            child: FlatButton(
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) {
                        return ClassifyCardDetail(id: item['id']);
                      }
                  ));
                },
                child: CircleAvatar(
                    backgroundImage: new NetworkImage(item['icon']),
                ),
            )
          )
      );
    }
    return list;
  }

  Future<Null> _onRefresh() async {
    offset = 0;
    _loadItemPage();
    return null;
  }

}