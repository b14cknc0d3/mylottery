import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/api/bloc.dart';
import 'package:my_lottery/src/ui/login/login_bloc/bloc.dart';
import 'package:my_lottery/src/utils/utils.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_lottery/src/widget/bottom_curve_painter.dart';

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
  Screen size;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  ApiLoader get _apiLoader => widget._apiLoader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _usernameController.addListener(_onUsernameChange);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    size = Screen(MediaQuery.of(context).size);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
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
                content: CircularProgressIndicator(),
              ),
//                content: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Text('Logging In...'),
//                    CircularProgressIndicator(),
//                  ],
//                ),
//              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(

            resizeToAvoidBottomPadding: false,
            key: _scaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Colors.transparent,
              ),
              sized: false,
              child: Container(
                color: colorCurve,
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipPath(
                        clipper: BottomShapeClipper(),
                        child: Container(
                          color: colorCurve,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.getWidthPx(20),
                            vertical: size.getWidthPx(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    height: 280,
                                    child: Image.asset("assets/dvm.jpg")),
                              ),
//                              _linearGradientText(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0, right: 28.0, top: 35.0),
                              ),
//                              SizedBox(
//                                height: size.getWidthPx(30),
//                              ),
                              _formWidget(state),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
//                  #################################
                                    LoginButton(
                                      onPressed: isLoginButtonEnabled(state)
                                          ? _onFormSubmitted
                                          : null,
                                    ),
//                  ######################################################
                                    SizedBox(height: size.getWidthPx(28)),
//
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _formWidget(state) {
    return Container(
      width: double.infinity,
      height: Screen(MediaQuery.of(context).size).getWidthPx(280),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _linearGradientText(),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: colorCurve,
                ),
                labelText: 'username',
              ),
              validator: (_) {
                return !state.isUsernameValid ? 'Invalid username' : null;
              },
              autocorrect: false,
            ),
            SizedBox(height: size.getWidthPx(8)),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: colorCurve,
                ),
                labelText: 'Password',
              ),
              obscureText: true,
              autovalidate: true,
              autocorrect: false,
              validator: (_) {
                return !state.isPasswordValid ? 'Invalid Password' : null;
              },
            ),
            SizedBox(height: size.getWidthPx(35)),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'only to search lottery?',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                FlatButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SearchHome())),
                  child: Text(
                    'click here',
                    style: TextStyle(
                        color: colorCurve,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                )
              ],
            )

//
          ],
        ),
      ),
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

  void _onUsernameChange() {
    _loginBloc.dispatch(
      UsernameChange(username: _usernameController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }
}

class SearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('SearchHome'),
    );
  }
}

GradientText _linearGradientText() {
  return GradientText('Login',
      gradient: LinearGradient(colors: [
        Color.fromRGBO(97, 6, 165, 1.0),
        Color.fromRGBO(45, 160, 240, 1.0)
      ]),
      style: TextStyle(
          fontSize: 36,
          fontFamily: "Poppins-Bold",
          letterSpacing: .6,
          fontWeight: FontWeight.bold));
}

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Screen(MediaQuery.of(context).size).getWidthPx(20),
          horizontal: Screen(MediaQuery.of(context).size).getWidthPx(16)),
      width: Screen(MediaQuery.of(context).size).getWidthPx(150),
      child: RaisedButton(
        elevation: 8.0,
        padding:
            EdgeInsets.all(Screen(MediaQuery.of(context).size).getWidthPx(12)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: colorCurve,
        onPressed: _onPressed,
        child: Text(
          'Login',
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }
}
