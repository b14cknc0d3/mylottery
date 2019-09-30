import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final String key;

  Authenticated({@required this.key})
      : assert(key != null),
        super([key]);

  @override
  String toString() => 'Authenticated { key: $key }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
class AuthenticationStateLoading extends AuthenticationState{
  @override
  String toString() => 'Auth_State Loading....';

}