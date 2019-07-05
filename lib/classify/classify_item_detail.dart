import 'package:flutter/material.dart';
import 'package:gank_flutter/classify/classify_card_detail.dart';

class ClassifyItemDetail extends StatefulWidget {
  final articleItem;
  final int index;

  const ClassifyItemDetail({Key key, this.articleItem, this.index}) : super(key: key);

  @override
  _ClassifyItemDetailState createState() => _ClassifyItemDetailState();
}

class _ClassifyItemDetailState extends State<ClassifyItemDetail> {

  @override
  Widget build(BuildContext context) {
    return new Container(

      child: new FlatButton(
          onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) {
                  return ClassifyCardDetail(id: widget.articleItem['id'],);
                }
            ));
          },
          child: new Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: new Row(
              children: <Widget>[

                new Expanded(
                    flex: 6,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            widget.articleItem['title'],
                            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.1, color: Colors.white70),
                          ),
                          padding: const EdgeInsets.only(bottom: 10.0,right: 4.0),
                          alignment: Alignment.topLeft,
                        ),
                        widget.articleItem['id'] != null ?
                        new Container(
                            child: new Text(widget.articleItem['id'], style: new TextStyle(color: Colors.white70)),
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(bottom: 8.0,right: 4.0)
                        ) : new Container(),
                        new Container(
                          child: new Text(widget.articleItem['created_at'], style: new TextStyle(color: Colors.white70)),
                          alignment: Alignment.topLeft,
                        )
                      ],
                    )
                ),
                new Expanded(
                    flex: 3,
                    child: new AspectRatio(
                        aspectRatio: 3.0 / 2.0,
                        child: new Container(
                          foregroundDecoration:new BoxDecoration(
                              image: new DecorationImage(
                                image: new NetworkImage(widget.articleItem['icon']),
                                centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                              ),
                              borderRadius: const BorderRadius.all(const Radius.circular(6.0))
                          ),
                        )
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}