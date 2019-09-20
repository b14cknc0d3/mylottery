import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const <dynamic>[]]) : super(props);
}

class TextChanged extends SearchEvent {
  final String text;

  TextChanged({@required this.text}) : super([text]);
  @override
  String toString() => 'TextChanged Text:$text';
}
