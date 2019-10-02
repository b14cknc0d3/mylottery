import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';
import 'package:my_lottery/src/ui/user_home/add_sale/sale_add_bloc/bloc.dart';
import 'package:my_lottery/src/ui/user_home/user_home.dart';
import 'package:my_lottery/src/widget/bottom_curve_painter.dart';
import 'package:my_lottery/src/utils/utils.dart';

class SaleListAddPage extends StatefulWidget {
  final SaleListAddBloc saleListAddBloc;
  final OneLs item;

  const SaleListAddPage ({Key key, this.saleListAddBloc, @required this.item}) : super( key: key );

  @override
  _SaleListAddPageState createState () =>
      _SaleListAddPageState( saleListAddBloc,);
}

class _SaleListAddPageState extends State<SaleListAddPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>( );
  final ApiLoader apiLoader = ApiLoader( ApiProvider( ) );
  SaleListAddBloc saleListAddBloc;




  Screen size;
  static const winnerMenuItem = <String>['0', '1'];
  static const prizeDetailsMenuItem = <String>[
    'L15k',
    'L05k',
    'L01k',
    'L500',
    'L100',
    'L050',
    'L010',
    'L001',
    'k005',
    '0000',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItem = winnerMenuItem
      .map( (String value) =>
      DropdownMenuItem<String>(
        value: value,
        child: Text( value ),
      ) )
      .toList( );
  final List<DropdownMenuItem<String>> _dropDownPDmenuItems =
  prizeDetailsMenuItem
      .map( (String value) =>
      DropdownMenuItem<String>(
        value: value,
        child: Text( value ),
      ) )
      .toList( );
  String _btn1SelectedValue;
  String _btn1PDSelectedValue = '0000';
  final TextEditingController _lnoTEC = TextEditingController();
  final TextEditingController _name = TextEditingController( );
  final TextEditingController _phone = TextEditingController( );
  final TextEditingController _address = TextEditingController( );
 OneLs _item = OneLs() ;

  _SaleListAddPageState (this.saleListAddBloc, );

  @override
  void initState () {

    super.initState( );

    saleListAddBloc = BlocProvider.of<SaleListAddBloc>( context );
  }

  @override
  void dispose () {
    // TODO: implement dispose
    super.dispose( );

    _lnoTEC.dispose( );
    _name.dispose( );
    _phone.dispose( );
    _address.dispose( );
  }

  @override
  Widget build (BuildContext context) {

    size = Screen( MediaQuery
        .of( context )
        .size );
    return BlocListener<SaleListAddBloc, SaleListAddState>(
      listener: (context, state) {
        if (state is SaleListAddStateLoading) {
          _scaffoldKey.currentState
            ..hideCurrentSnackBar( )
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text( 'adding data' ), Icon( Icons.add )],
                ),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state is SaleListAddErrorState) {
          _scaffoldKey.currentState
            ..hideCurrentSnackBar( )
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text( 'Add Data Failure' ), Icon( Icons.error )],
                ),
                backgroundColor: Colors.red,
              ),
            );
        } else if (state is SaleListAddSuccessState) {
          _scaffoldKey.currentState
            ..hideCurrentSnackBar( )
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( 'data added successfully' ),
                    Icon( Icons.check )
                  ],
                ),
                backgroundColor: Colors.green,
              ),
            );
        }
      },
      child: Material(
        color: colorCurve,
        child: Scaffold(
          backgroundColor: colorCurve,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: <Widget>[
            SafeArea(
            child: Stack(
                //fit: StackFit.loose,
                children: <Widget>[
                Container(
                height: MediaQuery.of(context ).size.height * .15,
            width: MediaQuery
                .of( context )
                .size
                .width,
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular( 30 ),
                  bottomRight: Radius.circular( 30 ) ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only( top: 20 ),
            child: _appBar( ),
          ),
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery
            .of( context )
            .size
            .height * 0.05,
        child: Container( ),
      ),
      Divider(
        color: Colors.black12,
      ),
      Container(
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
          borderRadius: BorderRadius.circular( 30 ),
        ),
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all( 8.0 ),
                  child: Divider( ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, bottom: 0, top: 8, right: 2 ),
                        child: TextFormField(

//                          initialValue:widget.item.lno ,


//                          controller: widget.item.lno == null ? _lnoTEC :_lnoTEC.text ='${widget.item.lno}' ,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(


                              border: OutlineInputBorder(


                                  borderRadius: BorderRadius.circular( 30 ),
                                  borderSide:
                                  BorderSide( color: Colors.green ) ),
                              labelText: 'lno',
                              icon: Icon( Icons.looks_one ) ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, bottom: 0, top: 8, right: 8 ),
                        child: TextFormField(

                          controller: _name,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular( 30 ),
                                borderSide:
                                BorderSide( color: Colors.green ) ),
                            labelText: 'name',
                            suffixIcon: Icon( Icons.clear ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 0,
                    top: 8,
                    right: 8,
                  ),
                  child: TextFormField(
                    controller: _phone,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular( 30 ),
                            borderSide: BorderSide( color: Colors.green ) ),
                        labelText: 'phone',
                        icon: Icon( Icons.looks_two ) ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 0,
                    top: 8,
                    right: 8,
                  ),
                  child: TextFormField(
                    controller: _address,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular( 30 ),
                            borderSide: BorderSide( color: Colors.green ) ),
                        labelText: 'address',
                        icon: Icon( Icons.looks_3 ) ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        dense: true,
                        selected: false,
                        title: Text(
                          'If not winner?Leave it!',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black,
//                                  backgroundColor: Colors.amber,
                            fontFamily: "Poppins-Bold",
                            letterSpacing: .6,
                          ),
                        ),
                        subtitle: Text(
                          'choose 1 if win->set-prize',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 10,
                            color: Colors.white,
                            backgroundColor: Colors.black,
                            fontFamily: "Poppins-Bold",
                            letterSpacing: .4,
                          ),
                        ),
                        leading: DropdownButton(
                          isExpanded: false,
                          iconEnabledColor: Colors.green,
                          icon: Icon( Icons.arrow_drop_down_circle ),
                          items: _dropDownMenuItem,
                          value: _btn1SelectedValue,
                          onChanged: ((String value) {
                            setState( () {
                              _btn1SelectedValue = value;
                              print( _btn1SelectedValue );
                            } );
                          }),
                        ),
                        trailing: DropdownButton<String>(
                          items: _dropDownPDmenuItems,
                          value: _btn1PDSelectedValue,
                          onChanged: ((String value) {
                            setState( () {
                              _btn1PDSelectedValue = value;
                              print( _btn1PDSelectedValue );
                            } );
                          }),
                        ),
                        contentPadding: EdgeInsets.only(
                            left: 8, bottom: 0, top: 20, right: 20 ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all( 8.0 ),
                  child: Divider( ),
                ),
              ],
            ) ),
      ),
      Divider( ),
      Row(
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all( 8.0 ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO( 12, 0, 165, 1.0 ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset( 0.0, 15.0 ),
                            blurRadius: 15.0 ),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset( 0.0, -1.0 ),
                            blurRadius: 10.0 ),
                      ],
                      borderRadius: BorderRadius.circular( 30 ) ),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'CANCLE',
                      style: TextStyle( color: Colors.white ),
                    ),
                  ),
                ),
              ) ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all( 8.0 ),
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 30 ) ,
                    color: Color.fromRGBO( 12, 222, 222, 2.0 ),
                    boxShadow: [

                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset( 0.0, 15.0 ),
                          blurRadius: 15.0 ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset( 0.0, -1.0 ),
                          blurRadius: 10.0 ),
                    ],),
                    child: FlatButton(
                      onPressed: () => _onSaleAdd( context ),
                      child: Text(
                        'ADD',
                        style: TextStyle( color: Colors.white ),
                      ),
                    ),
                  ),
                ) )
            ],
          )
        ],
      ),
    ),)
    ,
    )
    ,
    );
  }

  AppBar _appBar () {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorCurve,
          ),
          onPressed: () {
            Navigator.pushReplacement( context,
                MaterialPageRoute( builder: (BuildContext context) {
                  return UserHome(
                    apiLoader: apiLoader,
                  );
                } ) );
          } ),
      title: _linearGradientText( ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: <Widget>[],
    );
  }

  GradientText _linearGradientText () {
    return GradientText( 'SALE ADD PAGE',
        gradient: LinearGradient( colors: [
          Color.fromRGBO( 97, 6, 165, 1.0 ),
          Color.fromRGBO( 45, 160, 240, 1.0 )
        ] ),
        style: TextStyle(
            decorationColor: Colors.black,
            decorationThickness: 22,
            fontSize: 36,
            fontFamily: "Poppins-Bold",
            letterSpacing: .6,
            fontWeight: FontWeight.bold ) );
  }

  _onSaleAdd (BuildContext context) {
    OneLs listOneLs = OneLs(
      lno: _lnoTEC.text,
      address: _address.text,
      phone: _phone.text,
      prizeDetails: _btn1PDSelectedValue == '0000' ? '' : _btn1PDSelectedValue,
      isWinner: _btn1SelectedValue == null ? '' : _btn1SelectedValue,
    );
    saleListAddBloc.dispatch( SaleListAddBottomPressed( items: listOneLs ) );
  }

//####################################EOF#######################################################################
}
