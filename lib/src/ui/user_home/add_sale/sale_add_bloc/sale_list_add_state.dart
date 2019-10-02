import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SaleListAddState extends Equatable {
  SaleListAddState([List props = const <dynamic>[]]) : super(props);
}

class InitialSaleListAddState extends SaleListAddState {
  @override
  String toString()=> '-----------init sale list add state -----------';
}
class SaleListAddSuccessState extends SaleListAddState{
  final bool success;

  SaleListAddSuccessState(this.success):super([success]);
}

class SaleListAddErrorState extends SaleListAddState{
  final String error;

  SaleListAddErrorState(this.error);
  @override
  String toString() =>'------(x)saleListStateError(x) -----/x/x/x/x/x/--->error:$error';
}
class SaleListAddStateLoading extends SaleListAddState{

  @override
  String toString() =>'>>====(o)saleListStateLoading(o) ======>';
}