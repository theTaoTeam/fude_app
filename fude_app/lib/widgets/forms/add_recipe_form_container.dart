import 'package:flutter/material.dart';

import 'package:fude/helpers/categories.dart';
import 'package:fude/helpers/jars.dart';
import 'package:fude/widgets/form-inputs/image.dart';
import 'package:fude/widgets/form-inputs/add_recipe_inputs.dart';

class AddRecipeForm extends StatelessWidget {
  final GlobalKey formKey;
  final String selectedCategory;
  final String selectedJar;
  final Function updateCategory;
  final Function updateJar;
  final Function updateTitle;
  final Function updateLink;
  final Function updateDescription;
  final Function updateImage;

  AddRecipeForm(
      {this.formKey,
      this.selectedCategory,
      this.selectedJar,
      this.updateCategory,
      this.updateJar,
      this.updateTitle,
      this.updateLink,
      this.updateDescription,
      this.updateImage});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: DropdownButton(
                          hint: Text('category'),
                          value: selectedCategory,
                          items: categories.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          onChanged: (dynamic val) {
                            print(val);
                            updateCategory(val);
                          },
                        ),
                      ),
                      Container(
                        child: DropdownButton(
                          hint: Text('jar'),
                          value: selectedJar,
                          items: jars.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          onChanged: (dynamic val) {
                            print(val);
                            updateJar(val);
                          },
                        ),
                      ),
                    ],
                  ),
                  AddRecipeInput(
                    hint: "Title",
                    updateTitle: updateTitle,
                  ),
                  AddRecipeInput(
                    hint: "Link",
                    updateLink: updateLink,
                  ),
                  AddRecipeInput(
                    hint: "Description",
                    updateDescription: updateDescription,
                  ),
                  ImageInput(updateImage: updateImage),
                ],
              )),
        ],
      ),
    );
  }
}
