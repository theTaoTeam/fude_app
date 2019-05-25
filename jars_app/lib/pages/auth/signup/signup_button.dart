import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.8,
      height: height * 0.07,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Text(
        "signup",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 5,
        ),
      ),
    );
  }
}