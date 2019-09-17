import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const <dynamic>[]]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

class LoggedInNow extends AuthenticationEvent{
  final String key;

  LoggedInNow(this.key):super([key]);
  @override
  String toString() {
    // TODO: implement toString
    return 'Logged in now with : key : $key';
  }

}