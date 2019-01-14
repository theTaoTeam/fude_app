import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:fude/pages/home/main_view.dart';
import 'package:fude/scoped-models/main.dart';
import 'package:fude/widgets/side_drawer.dart';

class HomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(162, 146, 199, 0.8),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        drawer: buildSideDrawer(context, model),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[
                const Color.fromRGBO(162, 146, 199, 0.8),
                const Color.fromRGBO(51, 51, 63, 0.9),
              ],
              stops: [0.2, 1.0],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            )),
            child: MainView()),
      );
    });
  }
}
