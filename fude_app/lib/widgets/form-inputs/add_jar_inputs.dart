import 'package:flutter/material.dart';

class AddJarInputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Function updateEmail;
  final Function updatePassword;
  AddJarInputField(
      {this.hint, this.obscure, this.updateEmail, this.updatePassword});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
      ),
      child: TextFormField(
        obscureText: obscure,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black, fontSize: 15.0),
          contentPadding:
              EdgeInsets.only(top: 20.0, right: 20.0, bottom: 20.0, left: 5.0),
        ),
        onSaved: (String val) {
          print(val);
        },
      ),
    );
  }
}