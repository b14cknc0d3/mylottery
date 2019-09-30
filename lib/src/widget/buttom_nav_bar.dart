import 'package:flutter/material.dart';
import 'package:my_lottery/src/utils/utils.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class BottomCurvedNavBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  BottomCurvedNavBar ({Key key, this.changeCurrentTab}) : super( key: key );

  @override
  _BottomCurvedNavBarState createState () => _BottomCurvedNavBarState( );
}

class _BottomCurvedNavBarState extends State<BottomCurvedNavBar>
    with SingleTickerProviderStateMixin {
  int tab = 0;
  int currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey( );

  Screen size;

  @override
  Widget build (BuildContext context) {
    size = Screen( MediaQuery
        .of( context )
        .size );
    return BubbleBottomBar(
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem( icon: Icon( Icons.list, size: 30,color: Colors.black, ),activeIcon: Icon( Icons.list, size: 35,color: Colors.white, ),title: Text('home',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueAccent ),
        BubbleBottomBarItem( icon: Icon( Icons.show_chart, size: 30,color: Colors.black, ),activeIcon: Icon( Icons.show_chart, size: 35,color: Colors.white, ),title: Text('sale status',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueAccent ),
        BubbleBottomBarItem( icon: Icon( Icons.search, size: 30,color: Colors.black, ),activeIcon: Icon( Icons.search, size: 35,color: Colors.white, ),title: Text('serach',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueAccent ),
        BubbleBottomBarItem( icon: Icon( Icons.settings, size: 30,color: Colors.black, ),activeIcon: Icon( Icons.settings, size: 35,color: Colors.white, ),title: Text('settings',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueAccent ),
      ],
      opacity: 0.8,
      currentIndex: tab,
      onTap: (int index) {
        setState( () {
          if (index != 4) {
            tab = index;
            print(tab);
            widget.changeCurrentTab( tab );
          }
        }, );
      },
      fabLocation: BubbleBottomBarFabLocation.end,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      key: _bottomNavigationKey,
      hasNotch: true,
      hasInk: true,
      inkColor: Colors.black12,
      backgroundColor: getColor(Colors),
    );
  }

  getColor(Type colors) {
    switch (tab){
      case 0:
        return Colors.green;
        break;
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.deepPurpleAccent;
        break;
      case 3:
        return Colors.amberAccent;
        break;
    }
  }
}
//
//  @override
//  Widget build(BuildContext context) {
//    size = Screen(MediaQuery.of(context).size);
//    return CurvedNavigationBar(
//      key: _bottomNavigationKey,
//      index: 0,
//      height: 60.0,
//      items: <Widget>[
//        Icon(Icons.add, size: 30),
//        Icon(Icons.list, size: 30),
//        Icon(Icons.compare_arrows, size: 30),
//        Icon(Icons.call_split, size: 30),
//      ],
//      color: Colors.white,
//      buttonBackgroundColor: Colors.white,
//      backgroundColor: Colors.transparent,
//      animationCurve: Curves.decelerate,
//      animationDuration: Duration(milliseconds: 300),
//      onTap: (int index) {
//        setState(() {
//          if (index != 4) {
//            tab = index;
//            widget.changeCurrentTab(index);
//          }
//        });
//      },
//    );
//  }
//}
