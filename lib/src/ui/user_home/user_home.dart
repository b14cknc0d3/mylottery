import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/api/bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_lottery/src/ui/user_home/chart_view/chart.dart';
import 'package:my_lottery/src/ui/user_home/chart_view/chart_new.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_bloc/bloc.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_view.dart';
import 'package:my_lottery/src/utils/utils.dart';
import 'package:my_lottery/src/widget/BottomNavBar_Bloc/bloc.dart';
import 'package:my_lottery/src/widget/buttom_nav_bar.dart';

class UserHome extends StatelessWidget {
  final ApiLoader apiLoader;

  const UserHome({Key key, @required this.apiLoader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocProvider(
           providers: [
             BlocProvider<SaleListBloc>(
               builder: (BuildContext context) => SaleListBloc(apiLoader: apiLoader),
             ),
             BlocProvider<BottomNavBarBloc>(
              builder: (BuildContext context) => BottomNavBarBloc(),
             ),

           ],

        child: BlocProvider<BottomNavBarBloc>(
          builder: (context) => BottomNavBarBloc(),
          child: HomeListPage(apiLoader: apiLoader),
        ),
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
  AuthenticationBloc authenticationBloc;

  BottomNavBarBloc bottomNavBarBloc;

  _HomeListPageState();

  _changeCurrentTab(int tab) {
    setState(() {
      currentTab = tab;
      bottomNavBarBloc.dispatch(BnbIndexChangedEvent(index: tab));

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    _saleListBloc = BlocProvider.of<SaleListBloc>(context);
    bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: changeColors(Colors),
//      body: bodyView(currentTab),
      body: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
          builder: (context, state) {
        if (state is BnbIndexOneState) {
          return PageView(controller: pageController, children: [MyApp()]);
        } else if (state is BnbIndexTwoState) {
          return PageView(controller: pageController, children: []);
        } else if (state is BnbIndexThreeState) {
          return PageView(controller: pageController, children: [
            SettingsPage(
              authenticationBloc: authenticationBloc,
            )
          ]);
        } else if (state is BottomNavBarLoadingState) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return PageView(controller: pageController, children: [SaleListView()]);
      }),
      bottomNavigationBar: BottomCurvedNavBar(
        changeCurrentTab: _changeCurrentTab,
      ),
    );
  }

  changeColors(Type colors) {
    switch (currentTab) {
      case 0:
        return Colors.white;
        break;
      case 1:
        return Colors.white;
        break;
      case 2:
        return Colors.white;
        break;
      case 3:
        return Colors.white;
        break;
      default:
        return Colors.white;
    }
  }
}

class SettingsPage extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const SettingsPage({Key key, this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: FlatButton.icon(
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                  .dispatch(LoggedOut()),
              icon: Icon(Icons.exit_to_app),
              label: Text('Log Out')),
        ),
      ),
    );
  }
}
