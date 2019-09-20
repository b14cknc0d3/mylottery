import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:my_lottery/src/utils/utils.dart';

class SearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffd399c1),
                      Color(0xff9b5acf),
                      Color(0xff611cdf),
                    ],
                  ),
                ),
              ),
              _searchBox(),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  'Search,',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              )
            ],
          ),
          new Divider(),
          _carouselBox(),
          new Divider(),
          _winnerBox(),
          Divider(),
          _carouselBox(),
        ],
      ),
    );
  }

  Widget _winnerBox() {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          gradient: LinearGradient(
            colors: [
              Color(0xffd399c1),
              Color(0xff9b5acf),
              Color(0xff611cdf),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              contentPadding: EdgeInsets.only(left: 20),
              title: Container(
                child: Text(
                  'YOUR NUMBER A_123565 ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              subtitle: Text(
                '''WON \$3000000''',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellowAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
Widget _searchBox() {
  return Padding(
    padding: EdgeInsets.fromLTRB(8.0, 150, 8.0, 0),
    child: new Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ],
          borderRadius: BorderRadius.circular(40.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
              prefix: Icon(Icons.search),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.clear),
              labelText: 'search',
              contentPadding: EdgeInsets.only(left: 8.0, right: 8.0)),
        ),
//                    child: ListTile(
//                      leading: Icon(Icons.search),
//                      title: TextField(
//                        decoration: InputDecoration(
//                          hintText: 'search..',
//                        ),
//                      ),
//                      trailing: new Icon(Icons.clear),
//                    ),
      ),
    ),
  );
}
//#################XCAROUSEL IMAGE##############################################################

Widget _carouselBox() {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ],
      ),
      height: 200,
      child: Carousel(
        radius: Radius.circular(30.0),
        borderRadius: true,
        boxFit: BoxFit.cover,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 5.0,
        dotIncreasedColor: Colors.blue,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
          ExactAssetImage("assets/images/LaunchImage.jpg"),
        ],
      ),
    ),
  );
}
