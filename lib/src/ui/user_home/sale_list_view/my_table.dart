import 'package:my_lottery/src/model/dessert.dart';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:data_tables/data_tables.dart';

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
  @override
  _MyTableAppState createState() => _MyTableAppState();
}

class _MyTableAppState extends State<MyTableApp> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    _items = _tslList;
    super.initState();
  }

  void _sort<T>(
      Comparable<T> getField(Ntb d), int columnIndex, bool ascending) {
    _items.sort((Ntb a, Ntb b) {
      if (!ascending) {
        final Ntb c = a;
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

  List<Ntb> _items = [];
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        // theme: ThemeData.dark(),
        child: NativeDataTable.builder(
          alwaysShowDataTable: true,
          rowsPerPage: _rowsPerPage,
          itemCount: _items?.length ?? 0,
          firstRowIndex: _rowsOffset,
          handleNext: () async {
            setState(() {
              _rowsOffset += _rowsPerPage;
            });

            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
//            _items += [
//              Ntb('New Item 4', 159, 6.0, 24, 4.0, 87, 14, 1),
//              Ntb('New Item 5', 159, 6.0, 24, 4.0, 87, 14, 1),
//              Ntb('New Item 6', 159, 6.0, 24, 4.0, 87, 14, 1),
//            ];
            });
          },
          handlePrevious: () {
            setState(() {
              _rowsOffset -= _rowsPerPage;
            });
          },
//          mobileSlivers: <Widget>[
//            SliverAppBar(
//              title: Text("SEARCH RESULTS LIST"),
//            ),
//          ],
          itemBuilder: (int index) {
            final Ntb ntb = _items[index];
            return DataRow.byIndex(
                index: index,
                selected: ntb.selected,
                onSelectChanged: (bool value) {
                  if (ntb.selected != value) {
                    setState(() {
                      ntb.selected = value;
                    });
                  }
                },
                cells: <DataCell>[
                  DataCell(Container(
                      height: 20,
                      margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
                      color: Colors.white,
                      child: Text('${ntb.serialNo}'))),
                  DataCell(Text('${ntb.name}')),
                  DataCell(Text('${ntb.sex}')),
                  DataCell(Text('${ntb.address}')),
                  DataCell(Text('${ntb.townShipTbNo}')),
                  DataCell(Text('${ntb.nameOfTreatmentCenter}')),
                  DataCell(Text('${ntb.regGp}')),
                  DataCell(Text('${ntb.dsc}')),
                  DataCell(Text('${ntb.xPertR}')),
                  DataCell(Text('${ntb.culture}')),
                  DataCell(Text(
                    '${ntb.S}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.H}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.R}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.E}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.Z}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.am}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.cm}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.fq}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.ptoEto}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.other}'.toString(),
                  )),
                  DataCell(Text(
                    '${ntb.other2}'.toString(),
                  )),
                  DataCell(ButtonBar(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _items.remove(ntb);
                          });
                        },
                      ),
                    ],
                  )),
                ]);
          },
          header: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30)
              ),
              child: const Text('Data Management')),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          onRefresh: () async {
            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
              _items = _tslList;
            });
            return null;
          },
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
            print("New Rows: $value");
          },
//          mobileItemBuilder: (BuildContext context, int index) {
//            final i = _ntbs[index];
//            return ListTile(
//              title: Text(i?.name),
//            );
//          },
          onSelectAll: (bool value) {
            for (var row in _items) {
              setState(() {
                row.selected = value;
              });
            }
          },
          rowCountApproximate: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {},
            ),
          ],
          selectedActions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  for (var item in _items
                      ?.where((d) => d?.selected ?? false)
                      ?.toSet()
                      ?.toList()) {
                    _items.remove(item);
                  }
                });
              },
            ),
          ],
          mobileIsLoading: CircularProgressIndicator(),
          noItems: Text("Not  Found"),
          columns: <DataColumn>[
            DataColumn(
                label: const Text('SerailNo (date)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.serialNo, columnIndex, ascending)),
            DataColumn(
                label: const Text('Name'),
                tooltip: 'The Name OF Fooo',
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((Ntb d) => d.name, columnIndex, ascending)),
            DataColumn(
                label: const Text('Sex (m/f)'),
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((Ntb d) => d.sex, columnIndex, ascending)),
            DataColumn(
                label: const Text('Address'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Ntb d) => d.address, columnIndex, ascending)),
            DataColumn(
                label: const Text('Township TB No.'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Ntb d) => d.townShipTbNo, columnIndex, ascending)),
            DataColumn(
                label: const Text('Name of Treatment Center'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Ntb d) => d.nameOfTreatmentCenter,
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('Registration Group '),
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((Ntb d) => d.regGp, columnIndex, ascending)),
            DataColumn(
                label: const Text('Data Specimen collected'),
                tooltip:
                    'The amount of calcium as a percentage of the recommended daily amount.',
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((Ntb d) => d.dsc, columnIndex, ascending)),
            DataColumn(
                label: const Text('X-pert result'),
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((Ntb d) => d.xPertR, columnIndex, ascending)),
            DataColumn(
                label: const Text('Culture result'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Ntb d) => d.culture, columnIndex, ascending)),
            DataColumn(
                label: const Text('S)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.S, columnIndex, ascending)),
            DataColumn(
                label: const Text('H'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.H, columnIndex, ascending)),
            DataColumn(
                label: const Text('R'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.R, columnIndex, ascending)),
            DataColumn(
                label: const Text('E'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.E, columnIndex, ascending)),
            DataColumn(
                label: const Text('Z'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.Z, columnIndex, ascending)),
            DataColumn(
                label: const Text('Am'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.am, columnIndex, ascending)),
            DataColumn(
                label: const Text('Cm'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.cm, columnIndex, ascending)),
            DataColumn(
                label: const Text('Fq'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.fq, columnIndex, ascending)),
            DataColumn(
                label: const Text('Pho/Eto'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.ptoEto, columnIndex, ascending)),
            DataColumn(
                label: const Text('Other'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.other, columnIndex, ascending)),
            DataColumn(
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: const Text('Other')),
                ),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Ntb d) => d.other2, columnIndex, ascending)),
            DataColumn(
              label: const Text('Actions'),
            ),
          ],
        ),
      ),
    );
  }

  final List<Ntb> _tslList = <Ntb>[
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
    Ntb(
      1233435,
      'YeLinAung',
      'male',
      'chinpin',
      'monywa',
      'TreatMentCenter',
      'fooGroup',
      '19/1/1111',
      'fooXpert',
      'bazCulture',
      12,
      1.0,
      4.0,
      5.0,
      6.0,
      8.0,
      9.0,
      1.0,
      4.4,
      5.5,
      6.6,
    ),
  ];
}

//import 'package:flutter/material.dart';
//import 'dart:io' show Platform;
//import 'package:flutter/foundation.dart';
//import 'package:data_tables/data_tables.dart';
//import 'package:my_lottery/src/model/saledata_item.dart';
//
//class MyTable extends StatefulWidget {
//  final List<OneLs> items;
//
//  const MyTable({Key key, this.items}) : super(key: key);
//
//  @override
//  _MyTableState createState() => _MyTableState(this.items);
//}
//
//class _MyTableState extends State<MyTable> {
//  final List<OneLs> _saleList;
//  bool alwaysShowDataTable = true;
//  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//  int _sortColumnIndex;
//  bool _sortAscending = true;
//
//  _MyTableState(this._saleList);
//
//  List<OneLs> _items = [];
//  int _rowsOffset = 0;
//
//  @override
//  void initState() {
//    _items = _saleList;
//    super.initState();
//  }
//
//  void _sort<T>(
//      Comparable<T> getField(OneLs d), int columnIndex, bool ascending) {
//    _items.sort((OneLs a, OneLs b) {
//      if (!ascending) {
//        final OneLs c = a;
//        a = b;
//        b = c;
//      }
//      final Comparable<T> aValue = getField(a);
//      final Comparable<T> bValue = getField(b);
//      return Comparable.compare(aValue, bValue);
//    });
//    setState(() {
//      _sortColumnIndex = columnIndex;
//      _sortAscending = ascending;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.only(top:50.0),
//      child: Container(
//        color: Colors.white,
//        child: NativeDataTable.builder(
//          alwaysShowDataTable: alwaysShowDataTable,
//          rowsPerPage: _rowsPerPage,
//          handleNext: () async {
//            setState(() {
//              _rowsOffset += _rowsPerPage;
//            });
//
//            await new Future.delayed(new Duration(seconds: 3));
//            setState(() {});
//          },
//          handlePrevious: () {
//            setState(() {
//              _rowsOffset -= _rowsPerPage;
//            });
//          },
//          mobileSlivers: <Widget>[
//            SliverAppBar(
//              title: Text("SALE RESULTS LIST"),
//            ),
//          ],
//          itemCount: _items?.length ?? 0,
//
//          itemBuilder: (int index) {
//            final OneLs oneLs = _items[index];
//            return DataRow.byIndex(
//              index: index,
//              selected: oneLs.selected,
//              onSelectChanged: (bool value) {
//                if (oneLs.selected != value) {
//                  setState(() {
//                    oneLs.selected = value;
//                  });
//                }
//              },
//              cells: <DataCell>[
//                DataCell(Text('${oneLs.lno}')),
//                DataCell(Text('${oneLs.name}')),
//                DataCell(Text('${oneLs.address}')),
//                DataCell(Text('${oneLs.phone}')),
//                DataCell(Text('${oneLs.prizeDetails}')),
//                DataCell(Text('${oneLs.isWinner}')),
//                DataCell(Text('${oneLs.reseller}')),
//                DataCell(Text('${oneLs.createdAt}')),
//                DataCell(Text('${oneLs.updatedAt}')),
//                DataCell(ButtonBar(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(Icons.delete),
//                      onPressed: () {
//                        setState(() {
//                          _items.remove(oneLs);
//                        });
//                      },
//                    ),
//                    IconButton(
//                      icon: Icon(Icons.edit),
//                      onPressed: () {
//                        setState(() {
//                          _items.remove(oneLs);
//                        });
//                      },
//                    ),
//                  ],
//                ),
//                ),
//
//
//              ],
//            );
//
//          },
//          header: const Text('Data Management'),
//          sortColumnIndex: _sortColumnIndex,
//          sortAscending: _sortAscending,
//          onRefresh: () async {
//            await new Future.delayed(new Duration(seconds: 3));
//            setState(() {
//              _items = _items;
//            });
//            return null;
//          },
//          onRowsPerPageChanged: (int value) {
//            setState(() {
//              _rowsPerPage = value;
//            });
//            print("New Rows: $value");
//          },
////          mobileItemBuilder: (BuildContext context, int index) {
////            final i = _ntbs[index];
////            return ListTile(
////              title: Text(i?.name),
////            );
////          },
//          onSelectAll: (bool value) {
//            for (var row in _items) {
//              setState(() {
//                row.selected = value;
//              });
//            }
//          },
//          rowCountApproximate: true,
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.info_outline),
//              onPressed: () {},
//            ),
//          ],
//          selectedActions: <Widget>[
//            //TODO:?? edit delete table
//            Container(
//              child: IconButton(
//                icon: Icon(Icons.delete),
//                onPressed: () {
//                  setState(() {
//                    for (var item in _items
//                        ?.where((d) => d?.selected ?? false)
//                        ?.toSet()
//                        ?.toList()) {
//                      _items.remove(item);
//                    }
//                  });
//                },
//              ),
//            ),
//          ],
//          mobileIsLoading: CircularProgressIndicator(),
//          noItems: Text("Not  Found"),
//          columns: <DataColumn>[
//            DataColumn(
//                label: const Text('Lottery (No)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.lno, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('Customer (name)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.name, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('Customer (address)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.address, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('Customer (phone)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.phone, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('Reseller (name)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.reseller, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('Date (created at)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.createdAt, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('Date (updated at)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.name, columnIndex, ascending)),
//            DataColumn(
//                label: const Text('(action) (settings)'),
////              numeric: true,
//                onSort: (int columnIndex, bool ascending) =>
//                    _sort<String>((OneLs d) => d.name, columnIndex, ascending)),
//          ],
//        ),
//      ),
//    );
//  }
//}
