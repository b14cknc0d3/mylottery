import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/bloc.dart';

import './bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiLoader _apiLoader;
  final AuthenticationBloc _authenticationBloc;

  LoginBloc(
      {@required AuthenticationBloc authenticationBloc,
      @required ApiLoader apiLoader})
      : assert(
          apiLoader != null,
        ),
        _authenticationBloc = authenticationBloc,
        _apiLoader = apiLoader;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithUserNamePass) {
      yield* _mapLoginWithUserNamePass(
          username: event.username, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginWithUserNamePass(
      {String username, String password}) async* {
    yield LoginState.loading();
    try {
      final String key = await _apiLoader.doLogin(username, password);
      if (key.isNotEmpty){
        yield LoginState.success();
      }
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
