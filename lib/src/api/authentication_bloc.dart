import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiLoader _apiLoader;

  AuthenticationBloc({@required ApiLoader apiLoader})
      : assert(apiLoader != null),
        _apiLoader = apiLoader;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutState();
    }
  }

  // ignore: missing_return
  Stream<AuthenticationState> _mapAppStartedState() async* {
    try {
      final isSignedIn = await _apiLoader.hasKey();
      if (isSignedIn) {
        yield Authenticated(await _apiLoader.readKey());
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInState() async* {
    yield Authenticated(await _apiLoader.readKey());
  }

  Stream<AuthenticationState> _mapLoggedOutState() async* {
    yield Unauthenticated();
    _apiLoader.deleteKey();
  }
}
