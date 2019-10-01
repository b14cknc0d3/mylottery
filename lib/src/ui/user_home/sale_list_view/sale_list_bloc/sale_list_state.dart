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
  String toString() => 'SaleListStateSuccess => items count :${items.length}';

}
class SaleListStateError extends SaleListState{
  final String error;

  SaleListStateError(this.error);
  @override
  String toString() => 'SaleListState error $error';
}

class SaleListDeleteSuccess extends SaleListState{
  final bool success;

  SaleListDeleteSuccess({@required this.success}):super([success]);
  @override
  String toString() => 'SaleListDeletedSate --->success : ${success.toString()}';

}
class SaleListDeleteError extends SaleListState{
  final String error;

  SaleListDeleteError({@required this.error}):super([error]);
  @override
  String toString() => 'SaleListDeletedSate --->xerror : ${error.toString()}';

}