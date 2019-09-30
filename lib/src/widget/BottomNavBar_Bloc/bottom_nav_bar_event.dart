import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomNavBarEvent extends Equatable {
  BottomNavBarEvent([List props = const <dynamic>[]]) : super(props);
}
class BnbIndexChangedEvent extends BottomNavBarEvent{
  final int index;

  BnbIndexChangedEvent({@required this.index}):super([index]);
  @override
  String toString() =>'BottomNavBar IndexChanged index = $index';
}