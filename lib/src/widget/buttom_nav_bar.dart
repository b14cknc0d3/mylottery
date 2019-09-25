import 'package:flutter/material.dart';
import 'package:my_lottery/src/utils/utils.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomCurvedNavBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  BottomCurvedNavBar({Key key, this.changeCurrentTab}) : super(key: key);

  @override
  _BottomCurvedNavBarState createState() => _BottomCurvedNavBarState();
}

class _BottomCurvedNavBarState extends State<BottomCurvedNavBar>
    with SingleTickerProviderStateMixin {
  int tab = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.compare_arrows, size: 30),
        Icon(Icons.call_split, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: colorCurve,
      animationCurve: Curves.decelerate,
      animationDuration: Duration(milliseconds: 300),
      onTap: (int index) {
        setState(() {
          if (index != 4) {
            tab = index;
            widget.changeCurrentTab(index);
          }
        });
      },
    );
  }
}
