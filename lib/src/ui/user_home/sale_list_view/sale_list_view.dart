import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/my_table.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_bloc/bloc.dart';
import 'package:my_lottery/src/utils/utils.dart';

import '../user_home.dart';

class SaleListView extends StatefulWidget {
  @override
  _SaleListViewState createState() => _SaleListViewState();
}

class _SaleListViewState extends State<SaleListView> {
  final ApiLoader apiLoader = ApiLoader(ApiProvider());
  SaleListBloc _saleListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saleListBloc = BlocProvider.of<SaleListBloc>(context);
    _saleListBloc.dispatch(SaleListRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            _appBar(),
//            Divider(color: Colors.white,),


      ],


        ),

        Expanded(child: _DataTableView())  ],
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        'Sale Data List',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 29),
      ),
      centerTitle: true,
      bottomOpacity: 0.0,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}

class _DataTableView extends StatelessWidget {
//  final SaleListBloc _saleListBloc;
//
//  const _DataTableView({Key key, SaleListBloc saleListBloc})
//      : _saleListBloc = saleListBloc,
//        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTableApp();
//    return BlocBuilder<SaleListBloc, SaleListState>(
//      builder: (context, state) {
//        if (state is SaleListStateLoading) {
//          return CircularProgressIndicator();
//        }
//        if (state is SaleListStateError) {
//          return Padding(padding:EdgeInsets.fromLTRB(20, 150, 20, 10),child: MyTableApp());
//        }
//        if (state is SaleListStateSuccess) {
//          return state.items.isEmpty
//              ? Text('not data')
//              : Padding(padding: EdgeInsets.only(top: 150,left: 10),
//                  child: MyTableApp(),
//                );
//        }
//        return _showDialog(context);
//      },
//    );
  }

  Widget _showDialog(context) {
    return Center(
        child: Container(

      child: Text('resfresh'),
    ));
  }
}
