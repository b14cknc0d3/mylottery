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
//    } else if(event is LoggedInNow){
//      try{
//        _apiLoader.saveKey(event.key);
//        yield Authenticated(await _apiLoader.readKey());
//      }catch (e){
//
//      }

    }
  }

  // ignore: missing_return
  Stream<AuthenticationState> _mapAppStartedState() async* {

    try {
//      await Future.delayed(Duration(milliseconds: 300));
      final isSignedIn = await _apiLoader.hasKey();
      if (isSignedIn == true) {
//        yield AuthenticationStateLoading();

        yield Authenticated(key: await _apiLoader.readKey());
      } else {
//        yield AuthenticationStateLoading();
//        await Future.delayed(Duration(milliseconds: 300));
        yield Unauthenticated();
      }
    } catch (_) {
      await Future.delayed(Duration(milliseconds: 300));
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInState() async* {
    final String key = await _apiLoader.readKey();
    if (key != null) {

      yield Authenticated(key: key);
    }else{

      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutState() async* {
    yield Unauthenticated();
    _apiLoader.deleteKey();
  }
}
