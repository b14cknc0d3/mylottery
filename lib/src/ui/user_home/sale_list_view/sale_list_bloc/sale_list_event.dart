import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SaleListEvent extends Equatable {
  SaleListEvent([List props = const <dynamic>[]]) : super(props);
}

class SaleListRefresh extends SaleListEvent {
  @override
  String toString() => 'SaleListResh->SaleListEvent--->Refresed';
}

class SaleDataDeleteEvent extends SaleListEvent {
  final int id;

  SaleDataDeleteEvent({@required this.id}) : super([id]);

  @override
  String toString() => 'SaleDataDeleteButtomPressed => id :$id';
}
