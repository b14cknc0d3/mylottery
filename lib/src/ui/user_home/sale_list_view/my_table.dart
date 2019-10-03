import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:data_tables/data_tables.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/api_provider.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';
import 'package:my_lottery/src/ui/user_home/add_sale/add_sale_page.dart';
import 'package:my_lottery/src/ui/user_home/add_sale/edit_sale_page.dart';
import 'package:my_lottery/src/ui/user_home/add_sale/sale_add_bloc/bloc.dart';
import 'package:my_lottery/src/ui/user_home/sale_list_view/sale_list_bloc/bloc.dart';
import 'package:my_lottery/constance.dart';
// ignore: unused_element
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyTableApp extends StatefulWidget {
  final List<OneLs> items;

  const MyTableApp({Key key, this.items}) : super(key: key);

  @override
  _MyTableAppState createState() => _MyTableAppState(this.items);
}

class _MyTableAppState extends State<MyTableApp> {
  SaleListBloc saleListBloc;
  ApiLoader apiLoader = ApiLoader(ApiProvider());
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  int _sortColumnIndex;
  bool _sortAscending = true;
  bool _showNativeTable = true;

  final List<OneLs> items;

  _MyTableAppState(this.items);

  List<OneLs> _items = [];

//  get tableItemsCount => _items.length;

  @override
  void initState() {
    _items = items;
    super.initState();
    saleListBloc = BlocProvider.of(context);
  }

  void _sort<T>(
      Comparable<T> getField(OneLs d), int columnIndex, bool ascending) {
    _items.sort((OneLs a, OneLs b) {
      if (!ascending) {
        final OneLs c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
//        boxShadow: [
//          BoxShadow(
//              color: Colors.black12,
//              offset: Offset(0.0, 15.0),
//              blurRadius: 15.0),
//          BoxShadow(
//              color: Colors.black12,
//              offset: Offset(0.0, -10.0),
//              blurRadius: 10.0),
//        ],
//        borderRadius: BorderRadius.circular(30),
      ),
      // theme: ThemeData.dark(),
      child: NativeDataTable.builder(
        alwaysShowDataTable: _showNativeTable,
        rowsPerPage: _rowsPerPage,
        itemCount: _items?.length ?? 0,
        firstRowIndex: _rowsOffset,
        handleNext: () async {
          if (_rowsOffset <= _rowsPerPage) {
            setState(() {
              _rowsOffset += _rowsPerPage;
            });
          }
//
//          await new Future.delayed(new Duration(seconds: 3));
//          setState(() {
////            _items += [
////              Ntb('New Item 4', 159, 6.0, 24, 4.0, 87, 14, 1),
////              Ntb('New Item 5', 159, 6.0, 24, 4.0, 87, 14, 1),
////              Ntb('New Item 6', 159, 6.0, 24, 4.0, 87, 14, 1),
////            ];
//          });
        },
        handlePrevious: () {
          if (_rowsOffset > 0 || _rowsOffset < _rowsPerPage) {
            setState(() {
              _rowsOffset -= _rowsPerPage;
            });
          } else {
            _rowsOffset = 0;
          }
        },
//          mobileSlivers: <Widget>[
//            SliverAppBar(
//              title: Text("SEARCH RESULTS LIST"),
//            ),
//          ],
        itemBuilder: (int index) {
          final OneLs one = _items[index];
          print(one.phone);
          return DataRow.byIndex(
              index: index,
              selected: one.selected,
              onSelectChanged: (bool value) {
                if (one.selected != value) {
                  setState(() {
                    one.selected = value;
                  });
                }
              },
              cells: <DataCell>[
//                DataCell(Text('${one.id}')),
                DataCell(Text('${one.lno}')),
                DataCell(Text('${one.name}')),
                DataCell(Text('${one.phone.toString()}')),
                DataCell(Text('${one.address}')),
                DataCell(Text('${one.reseller}')),
                DataCell(Text('${one.prizeDetails.toLowerCase()}')),
                DataCell(Text('${one.isWinner}')),
                DataCell(Text('${one.createdAt}')),
                DataCell(Text('${one.updatedAt.toString()}')),
                DataCell(Text(
                  '${one.nth}'.toString(),
                )),
//                DataCell(ButtonBar(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(Icons.delete),
//                      onPressed: () {
//                        setState(() {
//                          _items.remove(one);
//                        });
//                      },
//                    ),
//                  ],
//                )),
              ]);
        },
        header: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30)),
            child: const Text('Data Management')),
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        onRefresh: () async {
          await new Future.delayed(new Duration(seconds: 3));
        },
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
          });
          print("New Rows: $value");
        },

        onSelectAll: (bool value) {
          for (var row in _items) {
            setState(() {
              row.selected = value;
            });
          }
        },
        rowCountApproximate: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              setState(() {
                _showNativeTable = _showNativeTable ? false : true;
              });
            },
          )
        ],
        selectedActions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
              semanticLabel: 'delete sale',
            ),
            onPressed: () {
              setState(() {
                var rowSelectedCount =
                    _items?.where((d) => d?.selected == true)?.toList()?.length;
                print('RSC :$rowSelectedCount');
                if (rowSelectedCount == 1) {
                  for (var row in _items) {
                    if (row.selected == true) {
                      print("u selected : ${row.id} ==> ${row.lno}");
                      saleListBloc.dispatch(SaleDataDeleteEvent(id: row.id));
                      Future.delayed(Duration(milliseconds: 300));

                      saleListBloc.dispatch(SaleListRefresh());
                    } else {
                      print('XxXxX');
                    }
                  }
                } else {
                  Scaffold.of(context)
                    ..showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        elevation: 2.0,
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                            label: 'x',
                            onPressed: () {
                              Scaffold.of(context)
                                ..hideCurrentSnackBar(
                                    reason: SnackBarClosedReason.hide);
                            }),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.warning),
                            Text(
                              'You can\'t delete multiple data at once !',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )));
                }
              });

//              apiLoader.deleteSale();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                var rowSelectedCount =
                    _items?.where((d) => d?.selected == true)?.toList()?.length;
                print('RSC :$rowSelectedCount');
                if (rowSelectedCount == 1 && rowSelectedCount != null) {
                  for (var row in _items) {
                    if (row.selected == true) {
                      print(row);
                      print("u selected to edit: ${row.id} ==> ${row.lno}");


                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider(
                              builder: (context) => SaleListAddBloc(apiLoader),
                              child: SaleListEditPage(
                                item: row,
                              ))));
                    } else {
                      print('cant edit error');
                    }
                  }
                } else {
                  Scaffold.of(context)
                    ..showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        elevation: 2.0,
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                            label: 'x',
                            onPressed: () {
                              Scaffold.of(context)
                                ..hideCurrentSnackBar(
                                    reason: SnackBarClosedReason.hide);
                            }),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.warning),
                            Text(
                              'You can\'t edit multiple data at once !',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )));
                }
              });
            },
          )
        ],
//        mobileIsLoading: CircularProgressIndicator(),
        noItems: Text("Not  Found"),
        columns: <DataColumn>[
//          DataColumn(
//              label: const Text('Lottery (ID)'),
//              numeric: true,
//              onSort: (int columnIndex, bool ascending) =>
//                  _sort<num>((OneLs d) => d.id, columnIndex, ascending)),
          DataColumn(
              label: const Text('Lottery (No)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((OneLs d) => d.lno, columnIndex, ascending)),
          DataColumn(
              label: const Text('Customer (name)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((OneLs d) => d.name, columnIndex, ascending)),
          DataColumn(
              label: const Text('Customer (phone)'),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((OneLs d) => d.phone, columnIndex, ascending)),
          DataColumn(
              label: const Text('Customer (address)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<String>(
                  (OneLs d) => d.address, columnIndex, ascending)),
          DataColumn(
              label: const Text('Reseller (name)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<String>(
                  (OneLs d) => d.reseller, columnIndex, ascending)),
          DataColumn(
              label: const Text('Details (prizes)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<String>(
                  (OneLs d) => d.prizeDetails, columnIndex, ascending)),
          DataColumn(
              label: const Text('Winner (or Not)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<String>(
                  (OneLs d) => d.isWinner, columnIndex, ascending)),
          DataColumn(
              label: const Text('Date (created at)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<String>(
                  (OneLs d) => d.createdAt, columnIndex, ascending)),
          DataColumn(
              label: const Text('Date (updated at)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<String>(
                  (OneLs d) => d.updatedAt, columnIndex, ascending)),
          DataColumn(
              label: const Text('Nth (times at)'),
//              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((OneLs d) => d.nth, columnIndex, ascending)),
//          DataColumn(
//            label: const Text('(action) (settings)'),
////              numeric: true,
//          ),
        ],
      ),
    );
  }
}
