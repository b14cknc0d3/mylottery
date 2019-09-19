import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/authentication_bloc.dart';
import 'package:my_lottery/src/ui/login/login_form.dart';

import 'login_bloc/bloc.dart';
import 'package:my_lottery/src/utils/utils.dart';
// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final ApiLoader _apiLoader;
  final AuthenticationBloc _authenticationBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginPage({
    @required ApiLoader apiLoader,
    AuthenticationBloc authenticationBloc,
  })  : assert(apiLoader != null),
        _authenticationBloc = authenticationBloc,
        _apiLoader = apiLoader;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     resizeToAvoidBottomInset: true,
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(
            apiLoader: _apiLoader, authenticationBloc: _authenticationBloc),
        child: LoginForm(apiLoader: _apiLoader),
      ),
    );
  }
}
