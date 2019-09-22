import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';

import 'package:my_lottery/src/ui/search_page/search_home_bloc/bloc.dart';

class SearchPage extends StatelessWidget {
  final ApiLoader apiLoader;

  const SearchPage ({Key key, this.apiLoader}) : super( key: key );

  @override
  Widget build (BuildContext context) {
    return Material(
      child: BlocProvider(
        builder: (context) => SearchBloc( apiLoader: apiLoader ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery
                      .of( context )
                      .size
                      .height * 0.25,
                  width: MediaQuery
                      .of( context )
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 15.0 ),
                    gradient: LinearGradient(
                      colors: [
                        Color( 0xffd399c1 ),
                        Color( 0xff9b5acf ),
                        Color( 0xff611cdf ),
                      ],
                    ),
                  ),
                ),
                _SearchBar( ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Text(
                    'Search,',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold ),
                  ),
                  centerTitle: true,
                )
              ],
            ),
            new Divider( ),
            _carouselBox( ),
            new Divider( ),
            _SearchBody( ),
            Divider( ),
//            _carouselBox(),
          ],
        ),
      ),
    );
  }
}

//###Search Body#################///
class _SearchBody extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return CircularProgressIndicator( );
        }
        if (state is SearchStateError) {
          return Text( state.error.toString( ) );
        }
        if (state is SearchStateSuccess) {
          return state.items.isEmpty
              ? Text( 'No Result' )
              :
//          Text('${state.items[0].lno} won ${state.items[0].prizeDetails.toString()}ks');
          Expanded( child: _SearchResults( items: state.items ) );
        }
        return Text( 'Enter Lottery Number to begin Search' );
      },
    );
  }
}

//#####
class _SearchResults extends StatelessWidget {
  final List<OneLs> items;

  const _SearchResults ({Key key, @required this.items}) : super( key: key );

  @override
  Widget build (BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return Padding( padding: EdgeInsets.all( 8.0 ),
            child: _SearchResultItem( item: items[i] ) );
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  final OneLs item;

  const _SearchResultItem ({Key key, @required this.item}) : super( key: key );

  @override
  Widget build (BuildContext context) {
    return ListTile(
      leading: CircleAvatar( child:Image.asset('assets/reward.png') ),
      title: Text( 'Your Lottery Number ${item.lno} Won' ),
      subtitle: Text( '${item.prizeDetails} ks' ),
    );
  }
}

//#####

class _SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState () => _SearchBarState( );
}

class _SearchBarState extends State<_SearchBar> {
  final _searchTextController = TextEditingController( );
  ApiLoader apiLoader = ApiLoader( ApiProvider( ) );
  SearchBloc _searchBloc;

  @override
  void initState () {
    super.initState( );
    _searchBloc = BlocProvider.of<SearchBloc>( context );
  }

  @override
  void dispose () {
    // TODO: implement dispose
    super.dispose( );
    _searchTextController.dispose( );
  }

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB( 8.0, 150, 8.0, 0 ),
      child: new Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset( 0.0, 15.0 ),
                  blurRadius: 15.0 ),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset( 0.0, -10.0 ),
                  blurRadius: 10.0 ),
            ],
            borderRadius: BorderRadius.circular( 40.0 ) ),
        child: Padding(
          padding: const EdgeInsets.all( 8.0 ),
          child: TextFormField(
            controller: _searchTextController,
            onFieldSubmitted: (text) {
              _searchBloc.dispatch( TextChanged( text: text ) );
            },
            onSaved: (text) {
              _searchBloc.dispatch( TextChanged( text: text ) );
            },
            decoration: InputDecoration(
                prefix: Icon( Icons.search ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  child: Icon( Icons.clear ),
                  onTap: _onClearTapped,
                ),
                labelText: 'search',
                contentPadding: EdgeInsets.only( left: 8.0, right: 8.0 ) ),
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

  void _onClearTapped () {
    _searchTextController.text = '';
    _searchBloc.dispatch( TextChanged( text: '' ) );
  }
}

Widget _carouselBox () {
  return Padding(
    padding: const EdgeInsets.all( 0.0 ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 30 ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset( 0.0, 15.0 ),
              blurRadius: 15.0 ),
          BoxShadow(
              color: Colors.black12,
              offset: Offset( 0.0, -10.0 ),
              blurRadius: 10.0 ),
        ],
      ),
      height: 200,
      child: Carousel(
        radius: Radius.circular( 30.0 ),
        borderRadius: true,
        boxFit: BoxFit.cover,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration( milliseconds: 1000 ),
        dotSize: 5.0,
        dotIncreasedColor: Colors.blue,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg' ),
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg' ),
          //ExactAssetImage( "assets/images/LaunchImage.jpg" ),
        ],
      ),
    ),
  );
}
//################## SEARCH BODY #########################//
