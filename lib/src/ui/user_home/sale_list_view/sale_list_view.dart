import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/my_table.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_bloc/bloc.dart';
import 'package:my_lottery/src/utils/utils.dart';

class SaleListView extends StatefulWidget {
  @override
  _SaleListViewState createState() => _SaleListViewState();
}

class _SaleListViewState extends State<SaleListView> {
  final ApiLoader apiLoader = ApiLoader( ApiProvider( ) );
  SaleListBloc _saleListBloc;

  @override
  Widget build (BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _appBar( ),
//            Divider(color: Colors.white,),
            Padding( padding: EdgeInsets.only( top: 50, ), child: Container(
              color: Colors.white,
              height: 100,

            ), ),
            Column(
              children: <Widget>[
               _DataTableView( ),

              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _appBar () {
    return AppBar(
      title: Text(
        'Sale Data List',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 29 ),
      ),
      centerTitle: true,
      bottomOpacity: 0.0,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

}
class _DataTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleListBloc,SaleListState>(
      builder: (context,state){
        if(state is SaleListStateLoading){
          return CircularProgressIndicator();
        }
        if(state is SaleListStateError){
          return Text('error');
        }
        if(state is SaleListStateSuccess){
          return state.items.isEmpty ? Text('not data'):Expanded(
            child: MyTable(items : state.items),
          );
        }
        return Text('refresh to update data');
      },

    );
  }
}
