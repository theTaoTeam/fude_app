import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

import 'package:fude/scoped-models/main.dart';
import 'package:fude/pages/jars/jar.dart';
import 'package:fude/pages/home/home_page_jar.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage({this.model});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    widget.model.fetchAllUserJars(widget.model.currUserEmail);
    super.initState();
  }

  void _openJar(int index) async {
    try {
      await widget.model
          .getJarBySelectedId(widget.model.usersJars[index].documentID);
      Navigator.push(
        context,
        PageTransition(
          curve: Curves.linear,
          type: PageTransitionType.downToUp,
          child: JarPage(model: widget.model),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: width * 0.7),
          child: GestureDetector(
            child: Text(
              'logout',
              style: TextStyle(
                color: Theme.of(context).primaryColor ==
                        Color.fromRGBO(242, 242, 242, 1)
                    ? Color.fromRGBO(40, 40, 40, 1)
                    : Color.fromRGBO(242, 242, 242, 1),
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            onTap: () => widget.model.logout(),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: height * 0.06),
        child: FloatingActionButton(
          shape: CircleBorder(),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).primaryColor,
          highlightElevation: 0,
          onPressed: () => widget.model.invertTheme(),
          child: !widget.model.isLoading
              ? Image.asset(
                  'assets/yinYang.png',
                  height: height * 0.15,
                  width: width * 0.15,
                )
              : Container(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0,
        child: Container(height: 20),
      ),
      body: !widget.model.isLoading
          ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  widget.model.usersJars.length == 0
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, height * 0.1, 0, 0),
                          width: width,
                          height: height * 0.55,
                          child: PageView.builder(
                              reverse: false,
                              pageSnapping: true,
                              controller: PageController(
                                  keepPage: false,
                                  viewportFraction: 0.8,
                                  initialPage: 0),
                              itemCount: widget.model.usersJars.length,
                              itemBuilder: (context, index) {
                                print(index);
                                return index == 0
                                    ? HomePageJar(
                                        model: widget.model, title: 'Add Jar')
                                    : GestureDetector(
                                        onTap: () => _openJar(index),
                                        child: HomePageJar(
                                            model: widget.model,
                                            jar: widget.model.usersJars[index],
                                            title: null),
                                      );
                              }),
                        )
                ],
              ),
            )
          : Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                ),
              ),
            ),
    );
  }
}
