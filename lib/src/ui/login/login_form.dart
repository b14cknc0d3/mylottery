import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/bloc.dart';
import 'package:my_lottery/src/ui/login/login_bloc/bloc.dart';

class LoginForm extends StatefulWidget {
  final ApiLoader _apiLoader;

  LoginForm({
    @required ApiLoader apiLoader,
  })  : assert(apiLoader != null),
        _apiLoader = apiLoader;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid  && !state.isSubmitting;
  }

  ApiLoader get _apiLoader => widget._apiLoader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print('Form:$state');
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        print('form builder:$state');
        return Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'username',
                ),
                autocorrect: false,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                obscureText: true,
                autovalidate: true,
                autocorrect: false,
                validator: (_) {
                  return !state.isPasswordValid ? 'Invalid Password' : null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    LoginButton(
                      onPressed:
                          isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                    )
                  ],
                ),
              ),

//
            ],
          )),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _onFormSubmitted() {
    _loginBloc.dispatch(
      LoginWithUserNamePass(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim()),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.lightGreen,
      onPressed: _onPressed,
      child: Text('Login'),
    );
  }
}
