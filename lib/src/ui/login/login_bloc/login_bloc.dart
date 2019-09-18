import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/bloc.dart';
import 'package:my_lottery/validators.dart';
import 'package:rxdart/rxdart.dart';
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
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! UsernameChange && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is UsernameChange || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UsernameChange) {
      yield* _mapUsernameChangeState(event.username);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangeState(event.password);
    } else if (event is LoginWithUserNamePass) {
      yield* _mapLoginWithUserNamePass(
          username: event.username, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginWithUserNamePass(
      {String username, String password}) async* {
    yield LoginState.loading();

    try {
      await _apiLoader.doLogin(username, password);
      final hasKey = await _apiLoader.hasKey();
      if (hasKey == true) {
        yield LoginState.success();
      }else{
        yield LoginState.failure();
      }
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapUsernameChangeState(String username) async* {
    yield currentState.update(
      isUsernameValid: Validators.isValidEmail(username),
    );
  }

  Stream<LoginState> _mapPasswordChangeState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }
}
