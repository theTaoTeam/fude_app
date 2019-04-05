import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

import 'package:fude/widgets/page_transformer/page_transformer.dart';
import 'package:fude/scoped-models/main.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    @required this.model,
    @required this.category,
    @required this.index,
    @required this.pageVisibility,
  });

  final String category;
  final int index;
  final MainModel model;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var titleText = Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          category.toUpperCase(),
          style: textTheme.title
              .copyWith(color: Color.fromRGBO(45, 45, 45, 1), fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      
    );

    return Positioned(
      top: 20,
      bottom: 20.0,
      left: 28.0,
      right: 28.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleText,
              // Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var image = ClipRRect(
    //   borderRadius: BorderRadius.circular(20.0),
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(),
    //     child: Image.network(
    //       'https://firebasestorage.googleapis.com/v0/b/fude-app.appspot.com/o/Scoot-01.png?alt=media&token=53fc26de-7c61-4076-a0cb-f75487779604',
    //       fit: BoxFit.cover,
    //       alignment: FractionalOffset(
    //         0.5 + (pageVisibility.pagePosition / 3),
    //         0.5,
    //       ),
    //     ),
    //   ),
    // );

    var imageOverlayGradient = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(235, 237, 238, 1),
                Color.fromRGBO(253, 251, 251, 1),
          ]),
          borderRadius: BorderRadius.circular(20),
        
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 10.0,
      ),
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageOverlayGradient,
            // _applyTextEffects(
            //   translationFactor: 50.0,
            //   child: Center(
            //     child: ,
            //   ),
            // ),
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
