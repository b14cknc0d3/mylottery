import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomNavBarState extends Equatable {
  BottomNavBarState([List props = const <dynamic>[]]) : super(props);
}

class BnbIndexZeroState extends BottomNavBarState {
  final int index = 0;

  @override
  String toString() => 'BottomNavBar Index  :$index';
}

class BnbIndexOneState extends BottomNavBarState {
  final int index;

  BnbIndexOneState({@required this.index})
      : assert(index != null && index == 1),
        super([index]);

  @override
  String toString() => 'BottomNavBar Index  :$index';
}

class BnbIndexTwoState extends BottomNavBarState {
  final int index;

  BnbIndexTwoState({@required this.index})
      : assert(index != null && index == 2),
        super([index]);

  @override
  String toString() => 'BottomNavBar Index  :$index';
}

class BnbIndexThreeState extends BottomNavBarState {
  final int index;

  BnbIndexThreeState({@required this.index})
      : assert(index != null && index == 3),
        super([index]);

  @override
  String toString() => 'BottomNavBar Index  :$index';
}

class BottomNavBarLoadingState extends BottomNavBarState {
  @override
  String toString() => 'BottomNavBarState Loading';
}

class BottomNavBarErrorState extends BottomNavBarState {
  final String error;

  BottomNavBarErrorState({@required this.error}) : super([error]);
  @override
  String toString()=>'BottomNavBarStateError || error(x)=>\t$error';
}
