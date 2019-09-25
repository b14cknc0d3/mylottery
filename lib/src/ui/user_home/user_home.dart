import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/api/bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_bloc/bloc.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_view.dart';
import 'package:my_lottery/src/widget/buttom_nav_bar.dart';


class UserHome extends StatelessWidget {
  final ApiLoader apiLoader;

  const UserHome({Key key,@required this.apiLoader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(

      child:  BlocProvider(builder: (context)=>SaleListBloc(apiLoader: apiLoader),
        child:HomeListPage(apiLoader : apiLoader),
        ),
        
      
    );
  }
}
class HomeListPage extends StatefulWidget {
  final ApiLoader apiLoader;

  const HomeListPage({Key key, this.apiLoader}) : super(key: key);
  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {

  int currentTab = 0;
  PageController pageController;
  ApiLoader apiLoader;
  SaleListBloc _saleListBloc;

  _HomeListPageState();
  _changeCurrentTab(int tab) {
    setState(() {
      currentTab = tab;

      pageController.jumpToPage(0);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saleListBloc = BlocProvider.of<SaleListBloc>(context);
    pageController = new PageController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: bodyView(currentTab),
      bottomNavigationBar: BottomCurvedNavBar(changeCurrentTab: _changeCurrentTab,),
    );
  }

    bodyView(int currentTab) {
    List<Widget> tabView = [];
    switch (currentTab) {
      case 0:
        tabView = [SaleListView()];
        break;

//      case 1:
//        tabView = [ChartView()];
//        break;
//      case 2:
//        tabView = [SearchView()];
//        break;
//
//      case 3:
//        tabView = [SettingsView()];
//        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}


//
//class UserHome extends StatefulWidget {
//  final ApiLoader _apiLoader;
//
//  UserHome({
//    @required ApiLoader apiLoader,
//  })  : assert(apiLoader != null),
//        _apiLoader = apiLoader;
//
//  @override
//  _UserHomeState createState() => _UserHomeState();
//}
//
//class _UserHomeState extends State<UserHome> with TickerProviderStateMixin {
//  int currentTab = 0;
//
//  PageController pageController;
//
////  SaleListBloc _saleListBloc;
//
//  ApiLoader apiLoader;
//
//  _changeCurrentTab(int tab) {
//    setState(() {
//      currentTab = tab;
//
//      pageController.jumpToPage(0);
//    });
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
////    _saleListBloc = BlocProvider.of<SaleListBloc>(context);
//    pageController = new PageController();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: BlocProvider<SaleListBloc>(
//        builder: (context) => SaleListBloc(apiLoader: apiLoader),
//        child: Scaffold(
//          body: bodyView(currentTab),
//          bottomNavigationBar: BottomCurvedNavBar(changeCurrentTab: _changeCurrentTab,),
//        ),
//      ),
//    );
//
//  }
//
//  bodyView(int currentTab) {
//    List<Widget> tabView = [];
//    switch (currentTab) {
//      case 0:
//        tabView = [SaleListView()];
//        break;
//
////      case 1:
////        tabView = [ChartView()];
////        break;
////      case 2:
////        tabView = [SearchView()];
////        break;
////
////      case 3:
////        tabView = [SettingsView()];
////        break;
//    }
//    return PageView(controller: pageController, children: tabView);
//  }
//}
