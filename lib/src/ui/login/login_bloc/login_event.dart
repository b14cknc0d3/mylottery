import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}
class Submitted extends LoginEvent {
  final String username;
  final String password;

  Submitted({@required this.username, @required this.password})
      : super([username, password]);

  @override
  String toString() {
    return 'Submitted { email: $username, password: $password }';
  }
}



class LoginWithUserNamePass extends LoginEvent {
  final String username;
  final String password;

  LoginWithUserNamePass({@required this.username, @required this.password})
      : super([username, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { username: $username, password: $password }';
  }
}