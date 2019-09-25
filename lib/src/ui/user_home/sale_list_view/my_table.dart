import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:data_tables/data_tables.dart';
import 'package:my_lottery/src/model/saledata_item.dart';

class MyTable extends StatefulWidget {
  final List<OneLs> items;

  const MyTable({Key key, this.items}) : super(key: key);

  @override
  _MyTableState createState() => _MyTableState(this.items);
}

class _MyTableState extends State<MyTable> {
  final List<OneLs> saleList;
  bool alwaysShowDataTable = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  _MyTableState(this.saleList);

  List<OneLs> _items = [];
  int _rowsOffset = 0;

  @override
  void initState() {
    _items = saleList;
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NativeDataTable.builder(
        alwaysShowDataTable: alwaysShowDataTable,
        rowsPerPage: _rowsPerPage,
        handleNext: () async {
          setState(() {
            _rowsOffset += _rowsPerPage;
          });

          await new Future.delayed(new Duration(seconds: 3));
          setState(() {});
        },
        handlePrevious: () {
          setState(() {
            _rowsOffset -= _rowsPerPage;
          });
        },
        mobileSlivers: <Widget>[
          SliverAppBar(
            title: Text("SALE RESULTS LIST"),
          ),
        ],
        itemCount: _items?.length ?? 0,
        columns: null,
        itemBuilder: (int index) {
          final OneLs oneLs = _items[index];
          return DataRow.byIndex(
            index: index,
            selected: oneLs.selected,
            onSelectChanged: (bool value) {
              if (oneLs.selected != value) {
                setState(() {
                  oneLs.selected = value;
                });
              }
            },
            cells: <DataCell>[
              DataCell(Text('${oneLs.lno}')),
              DataCell(Text('${oneLs.name}')),
              DataCell(Text('${oneLs.address}')),
              DataCell(Text('${oneLs.phone}')),
              DataCell(Text('${oneLs.prizeDetails}')),
              DataCell(Text('${oneLs.isWinner}')),
              DataCell(Text('${oneLs.reseller}')),
              DataCell(Text('${oneLs.createdAt}')),
              DataCell(Text('${oneLs.updatedAt}')),
              DataCell(ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _items.remove(oneLs);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        _items.remove(oneLs);
                      });
                    },
                  ),
                ],
              ),
              ),


            ],
          );
        },
      ),
    );
  }
}
