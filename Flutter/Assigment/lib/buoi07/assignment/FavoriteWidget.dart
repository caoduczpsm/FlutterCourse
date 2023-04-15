
import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget{
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget>{
  bool _isFavorited = true;
  int _favoriteCount = 30;

  @override
  Widget build(BuildContext context) {

    final mainImage = Image.asset(
      'images/lake.jpg',
      height: 300,
      fit: BoxFit.cover,
    );

    var favoriteRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Oeschinen Lake Camground",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Kandersteg, Switzerland",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              IconButton(
                alignment: Alignment.centerRight,
                icon: (_isFavorited ?
                const Icon(Icons.star) :
                const Icon(Icons.star_border)),
                color: Colors.red[500],
                onPressed: _toggleFavorite,
              ),
              SizedBox(
                width: 18,
                child: SizedBox(
                  child: Text('$_favoriteCount', style: const TextStyle(fontSize: 16),),
                ),
              )
            ],
          )
        ),
      ],
    );

    var iconRow = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.call, color: Colors.blueAccent[400], size: 25),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "CALL",
                  style: TextStyle(color: Colors.blueAccent[400], fontSize: 14),),
              )
            ],
          ),
          Column(
            children: [
              Icon(Icons.route, color: Colors.blueAccent[400], size: 25),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "ROUTE",
                  style: TextStyle(color: Colors.blueAccent[400], fontSize: 14),),
              )
            ],
          ),
          Column(
            children: [
              Icon(Icons.share, color: Colors.blueAccent[400], size: 25,),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "SHARE",
                  style: TextStyle(color: Colors.blueAccent[400], fontSize: 14),),
              )
            ],
          ),
        ],
      ),
    );

    var description = const Text(
      "Lake Oeschinen lies at the foot of the Bluemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-four walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing and riding the summer toboggan run.",
      style: TextStyle(
          fontSize: 16
      ),
    );

    final mainColumn = Column(
      children: [
        mainImage,
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              favoriteRow,
              iconRow,
              description,
            ],
          ),
        )
      ],
    );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            mainColumn
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(){
    setState(() {
      if(_isFavorited){
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}