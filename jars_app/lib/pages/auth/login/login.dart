import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/animation.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:jars/scoped-models/main.dart';

import 'package:jars/pages/auth/signup/signup_link.dart';
import 'package:jars/pages/auth/login/login_button.dart';
import 'package:jars/helpers/exceptions.dart';
import 'package:jars/widgets/forms/form_container.dart';
import 'package:jars/widgets/logo.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AnimationController _loginButtonController;
  var animationStatus = 0;
  final bool isLogin = true;

  final Map<String, String> _formData = {
    'email': null,
    'password': null,
  };

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  void updateEmail(String email) {
    setState(() {
      _formData['email'] = email;
    });
    // print('Email saved: ' + _formData['email']);
  }

  void updatePassword(String password) {
    _formData['password'] = password;
    // print('Password saved: ' + _formData['password']);
  }

  void _submitForm({Function login}) async {
    if (!formKey.currentState.validate()) {
      return;
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      formKey.currentState.save();
      try {
        await login(email: _formData['email'], password: _formData['password']);
        Navigator.pushReplacementNamed(context, '/');
      } on CausedException catch (exc) {
        exc.debugPrint();
        _showErrorDialog(context: context, userMessage: exc.userMessage);
      } catch (e) {
        _showErrorDialog(
          context: context,
        );
      }
    }
  }

  void _showErrorDialog({BuildContext context, String userMessage}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Aw Geeze!',
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 8,
            ),
          ),
          content: Text(
            userMessage,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              // fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 3,
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        body: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Logo(isLogin: true),
                        model.resetLinkSent
                            ? Text(
                                'check your email!',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )
                            : Container(),
                        FormContainer(
                            formKey: formKey,
                            updateEmail: updateEmail,
                            updatePassword: updatePassword,
                            isLogin: isLogin),
                        SignUp()
                      ],
                    ),
                    !model.isLoading
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 50.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  animationStatus = 1;
                                });
                                _submitForm(login: model.login);
                              },
                              child: LoginInButton(),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: 50.0),
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                              strokeWidth: 4,
                            ),
                          ),
                  ],
                ),
              ],
            )),
      );
    });
  }
}
