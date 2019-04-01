import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fude/scoped-models/main.dart';
import 'package:fude/pages/home/jars/jar.dart';
import 'package:fude/pages/home/jars/home_page_jar.dart';
import 'package:fude/widgets/page_transformer/page_transformer.dart';
import 'package:fude/helpers/design_helpers.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage({this.model});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  PageController controller;
  int currentpage = 0;
  double animatedHeight = 100;
  double animatedWidth = 100;
  bool hasJars = false;
  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: .85,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 251, 251, 1),
        elevation: 0.0,
        title: GestureDetector(
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/fude-app.appspot.com/o/Icon%20Dark.png?alt=media&token=717822bd-3e49-46e7-b7d8-1b432afd3e50',
            height: height * 0.2,
            width: width * 0.2,
          ),
          onTap: () => print('invert theme pressed'),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [
                Color.fromRGBO(235, 237, 238, 1),
                Color.fromRGBO(253, 251, 251, 1),
              ]),
          // borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance.collection('jars').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print('no jars');
                    return Container();
                  } else {
                    hasJars = true;
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, height * 0.1, 0, 0),
                      width: width,
                      height: height * 0.55,
                      child: PageTransformer(
                        pageViewBuilder: (context, visibilityResolver) {
                          return PageView.builder(
                            reverse: true,
                            controller: PageController(
                                viewportFraction: 0.88, initialPage: 1),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              final PageVisibility pageVisibility =
                                  visibilityResolver
                                      .resolvePageVisibility(index);

                              return GestureDetector(
                                onTap: () {
                                  widget.model.getJarBySelectedId(snapshot
                                      .data.documents[index].documentID);
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      curve: Curves.linear,
                                      type: PageTransitionType.fade,
                                      child: JarPage(model: widget.model),
                                    ),
                                  );
                                },
                                child: HomePageJar(
                                  model: widget.model,
                                  jar: snapshot.data.documents[index],
                                  pageVisibility: pageVisibility,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
