import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {

  @override
  State<FavoritePage> createState() => new _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Text('Favorite'),
    );
  }

}