import 'package:flutter/material.dart';

import 'package:fude/widgets/form-inputs/add_jar_name_input.dart';
import 'package:fude/widgets/form-inputs/add_jar_category_input.dart';
import 'package:fude/widgets/form-inputs/image.dart';

class AddJarForm extends StatelessWidget {
  final GlobalKey formKey;
  final int categoryCount;
  final Function updateTitle;
  final Function updateCategory;
  final Function updateImage;
  final Function incrementCategoryCount;

  AddJarForm(
      {this.formKey,
      this.categoryCount,
      this.updateTitle,
      this.updateCategory,
      this.updateImage,
      this.incrementCategoryCount});

  
  Widget _buildFormTitles(String title) {
    return Row(
      mainAxisAlignment: title == "ADD SOME CATEGORIES" ?MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style:
              TextStyle(color: Color.fromRGBO(236, 240, 241, 1), fontSize: 16),
          textAlign: TextAlign.start,
        ),
        title == "ADD SOME CATEGORIES"
            ? IconButton(
                icon: Icon(Icons.add_circle_outline),
                iconSize: 20,
                color: Color.fromRGBO(236, 240, 241, 0.7),
                onPressed: () {
                  incrementCategoryCount();
                })
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
          key: formKey,
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildFormTitles("YOUR JAR NAME"),
              SizedBox(height: 40),
              AddJarNameField(
                hint: "Name",
                updateTitle: updateTitle,
              ),
              SizedBox(height: 40),
              _buildFormTitles("ADD SOME CATEGORIES"),
              SizedBox(height: 40),
              AddJarCategoryField(
                hint: 'Category',
                updateCategory: updateCategory,
              ),
              SizedBox(height: 20),
              AddJarCategoryField(
                hint: 'Category',
                updateCategory: updateCategory,
              ),
              SizedBox(height: 20),
              AddJarCategoryField(
                hint: 'Category',
                updateCategory: updateCategory,
              ),
              SizedBox(height: 40),
              _buildFormTitles("HOW ABOUT AN IMAGE?"),
              SizedBox(height: 30),
              ImageInput(
                updateImage: updateImage,
              )
            ],
          )),
    );
  }
}
