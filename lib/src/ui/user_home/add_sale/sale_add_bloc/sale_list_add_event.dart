import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';

@immutable
abstract class SaleListAddEvent extends Equatable {
  SaleListAddEvent([List props = const <dynamic>[]]) : super(props);
}

class SaleListAddBottomPressed extends SaleListAddEvent {
  final OneLs items;

  SaleListAddBottomPressed({@required this.items}) : assert(items != null);

  @override
  String toString() => '''SaleListAddBottomPressed items :  \n
                                     $items        
                                     
                       ''';
}

class SaleListPatchBottomPressed extends SaleListAddEvent {
  final OneLs items;

  SaleListPatchBottomPressed({@required this.items}) : assert(items != null);

  @override
  String toString() => '''SaleListPatchBottomPressed items :  \n
                                     $items        
                                     
                       ''';
}