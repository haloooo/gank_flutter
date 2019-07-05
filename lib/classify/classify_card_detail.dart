import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/utils/API.dart';
import 'package:gank_flutter/classify/classify_card.dart';

class ClassifyCardDetail extends StatefulWidget {
  final String id;
  const ClassifyCardDetail({Key key, this.id}) : super(key: key);

  @override
  _ClassifyCardDetailState createState() => _ClassifyCardDetailState();
}

class _ClassifyCardDetailState extends State<ClassifyCardDetail> {
  List itemList = List();
  int offset = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadItemPage();
    _scrollController = ScrollController()..addListener(() {});
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        offset += 1;
        _loadItemPage();
      }
    });
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
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.id),
          backgroundColor: Colors.transparent,
        ),
        body: RefreshIndicator(
            child: itemList.length > 0 ?
            ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(8.0),
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index){
                  return ClassifyCard(articleItem: itemList[index], index: index,);
                }
            ) : Center(child: CircularProgressIndicator()),
            onRefresh: _onRefresh
        ),
      ),
    );
  }

  _loadItemPage() async{
    Dio dio = new Dio();
    String url = GankApi.API_CATEGORY_DATA+"${widget.id}/count/10/page/$offset";
    Response response=await dio.get(url);
    if(response.statusCode == 200){
      setState(() {
        if(offset == 1){
          itemList = response.data['results'];
        }else{
          itemList.addAll(response.data['results']);
        }
      });
    }
  }

  Future<Null> _onRefresh() async {
    offset = 1;
    _loadItemPage();
    return null;
  }

}