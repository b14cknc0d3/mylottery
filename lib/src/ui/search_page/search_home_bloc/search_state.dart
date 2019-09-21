import 'package:equatable/equatable.dart';
import 'package:my_lottery/src/model/search_result_list.dart';



abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class SearchStateEmpty extends SearchState {
  @override
  String toString() => 'SearchStateEmpty';
}

class SearchStateLoading extends SearchState {
  @override
  String toString() => 'SearchStateLoading';
}

class SearchStateSuccess extends SearchState {
  final List<SaleResultItem> items;

  SearchStateSuccess(this.items) : super([items]);

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends SearchState {
  final String error;

  SearchStateError(this.error) : super([error]);

  @override
  String toString() => 'SearchStateError';
}

class SearchStateNotWinner extends SearchState{
  @override
  String toString() =>'SearchStateNotWinner>>!';
}