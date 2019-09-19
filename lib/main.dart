import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/simple_bloc_delegate.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/ui/login/login_page.dart';

import 'src/api/api_provider.dart';
import 'src/api/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final ApiProvider apiProvider = ApiProvider();
  final ApiLoader apiLoader = ApiLoader(apiProvider);
  runApp(
    BlocProvider(
      builder: (context) =>
          AuthenticationBloc(apiLoader: apiLoader)..dispatch(AppStarted()),
      child: App(apiLoader: apiLoader),
    ),
  );
}

class App extends StatelessWidget {
  final ApiLoader _apiLoader;
  final AuthenticationBloc _authenticationBloc;

  const App(
      {@required Key key,
      ApiLoader apiLoader,
      AuthenticationBloc authenticationBloc})
      : assert(apiLoader != null),
        _apiLoader = apiLoader,
        _authenticationBloc = authenticationBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        print(state);
        if (state is Unauthenticated) {
          return LoginPage(apiLoader: _apiLoader);
        }
        if (state is Authenticated) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          return UserHomeScreen(
            authenticationBloc: _authenticationBloc,
          );
        } else {
          return LoginPage(apiLoader: _apiLoader);
        }
      }),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Splash Screen'),
    );
  }
}

class UserHomeScreen extends StatelessWidget {
  final AuthenticationBloc _authenticationBloc;

  const UserHomeScreen({Key key, AuthenticationBloc authenticationBloc})
      : _authenticationBloc = authenticationBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Userhome'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut())),
        ],
      ),
    );
  }
}
