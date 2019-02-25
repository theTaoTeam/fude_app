import 'package:flutter/material.dart';

import 'package:fude/widgets/form-inputs/add_jar_inputs.dart';

class AddJarForm extends StatelessWidget {
  final GlobalKey formKey;

  AddJarForm({this.formKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AddJarInputField(
                    hint: "Name",
                    obscure: false,
                    // updateEmail: updateEmail,
                  ),
                  AddJarInputField(
                    hint: "Contributors",
                    obscure: false,
                    // updateEmail: updateEmail,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
