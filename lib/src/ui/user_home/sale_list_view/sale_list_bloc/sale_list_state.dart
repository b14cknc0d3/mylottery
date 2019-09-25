import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';

@immutable
abstract class SaleListState extends Equatable {
  SaleListState([List props = const <dynamic>[]]) : super(props);
}

class SaleListStateEmpty extends SaleListState {
  @override
  String toString() =>'SaleListStateEmpty';
}

class SaleListStateLoading extends SaleListState{
  @override
  String toString() =>'SaleListStateLoading';
}
class SaleListStateSuccess extends SaleListState{
final  List<OneLs> items;

  SaleListStateSuccess({@required this.items}):super([items]);
  @override
  String toString() => 'SaleListStateSuccess => items :$items';

}
class SaleListStateError extends SaleListState{
  @override
  String toString() => 'SaleListState error';
}