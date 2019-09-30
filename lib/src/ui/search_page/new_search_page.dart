import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';
import 'package:my_lottery/src/widget/my_flutter_app_icons.dart';

import 'package:my_lottery/src/ui/search_page/search_home_bloc/bloc.dart';

import '../../../validators.dart';

class SearchPage extends StatelessWidget {
  final ApiLoader apiLoader;

  const SearchPage ({Key key, this.apiLoader}) : super( key: key );

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      color: Colors.blueAccent,


      theme: ThemeData.light( ),

      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        builder: (context) => SearchBloc( apiLoader: apiLoader ),
        child: Container(
          color: Colors.white,
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
                      'Search...',
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

              Divider(
                height: 10,
              ),
              _SearchBody( ),

//            _carouselBox(),
            ],
          ),
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
              ? Text(
            'No Result',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w600 ),
          )
              :
//          Text('${state.items[0].lno} won ${state.items[0].prizeDetails.toString()}ks');
          Expanded( child: _SearchResults( items: state.items ) );
        }
        return Text(
          'Enter Lottery Number to begin Search',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600 ),
        );
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
        return Padding(
            padding: EdgeInsets.all( 8.0 ),
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
    return Card(
      child: Container(
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
        child: ListTile(
          trailing: Padding(
            padding: const EdgeInsets.only( top: 3.0 ),
            child: IconButton(
                icon: Icon(
                  Icons.share,
                  semanticLabel: 'Share',
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {} ),
          ),
//          trailing: CircleAvatar(
//            backgroundColor: Colors.transparent,
//            foregroundColor: Colors.white,
//            child: Image.asset(
//              'assets/share.png'
//            ),
//          ),
//leading: Icon(MyFlutterApp.award,color: Colors.yellowAccent,size: 40,),
          leading: Padding(
            padding: const EdgeInsets.only( top: 8.0 ),
            child: CircleAvatar(
                child: Image.asset(
                  'assets/reward3.png',
                ) ),
          ),
          title: Text(
            'Your Lottery Number ${item.lno} Won',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                wordSpacing: 0.7 ),
          ),
          subtitle: Text(
            '${item.prizeDetails} ks',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23 ),
          ),
        ),
      ),
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
  final _focusNode = FocusNode( );
  ApiLoader apiLoader = ApiLoader( ApiProvider( ) );
  SearchBloc _searchBloc;

  bool autoValidate = false;

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
    _focusNode.dispose( );
  }

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB( 8.0, 100, 8.0, 10 ),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
            BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 15.0),
            blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),],
            borderRadius: BorderRadius.circular( 30.0 ),
        ),
        child: Card(
          shape: StadiumBorder( side: BorderSide( color: Colors.blueAccent ) ),
//          elevation: 30.0,
          child: Padding(
            padding: const EdgeInsets.only(left:8,right:8),
            child: TextFormField(




              controller: _searchTextController,

              onFieldSubmitted: (text) {
                if (Validators.isValidSearch( _searchTextController.text ) ==
                    true) {
                  _searchBloc.dispatch( TextChanged( text: text ) );
                  setState(() {
                    autoValidate = false;
                  });
                }else{
                  setState(() {
                    autoValidate = true;
                  });
                }
              },

//            onSaved: (text) {
//              _searchBloc.dispatch(TextChanged(text: text));
//            },
              focusNode: _focusNode,
              textAlign: TextAlign.center,


              style: TextStyle( fontWeight: FontWeight.w600, fontSize: 22 ),

              autocorrect: false,

              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  focusColor: Colors.white,


                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorText: autoValidate ? 'သင့်ရဲ့ ထီနံပါတ်ကိုရိုက်ထည့်ပါ': null,
                  hintMaxLines: 7,

                  counterStyle: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold ),

                  prefixIcon: Icon( Icons.search ),
                    hintText: 'search here',
                  suffixIcon: IconButton(
                    icon: Icon( Icons.clear ),
                    onPressed: _onClearTapped,
                  ),
//                  labelText: 'search',
                  contentPadding: EdgeInsets.only(
                      left: 30.0, top: 10, right: 8.0, bottom: 1 ) ),
            ),
          ),
        ),
      ),
    );
  }

  void _onClearTapped () {
    _searchTextController.text = '';
    // _searchBloc.dispatch( TextChanged( text: '' ) );
    setState( () {
      autoValidate = false;
    } );
  }



}

Widget _carouselBox () {
  return Padding(
    padding: const EdgeInsets.all( 0.0 ),
    child: SizedBox(
      height: 210,
      child: Carousel(
        radius: Radius.circular( 0.0 ),
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
