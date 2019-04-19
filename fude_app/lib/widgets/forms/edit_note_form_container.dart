import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fude/widgets/form-inputs/image.dart';
import 'package:fude/widgets/form-inputs/edit_note_input.dart';

class EditNoteForm extends StatelessWidget {
  final GlobalKey formKey;
  final DocumentSnapshot note;
  final String selectedCategory;
  final List<dynamic> categoryList;
  final bool nullCategory;
  final Function updateCategory;
  final Function updateName;
  final Function updateLink;
  final Function updateNotes;
  final Function updateImage;

  EditNoteForm(
      {this.formKey,
      this.note,
      this.categoryList,
      this.nullCategory,
      this.selectedCategory,
      this.updateCategory,
      this.updateName,
      this.updateLink,
      this.updateNotes,
      this.updateImage});

  Widget _buildTextSections(String hint, String val) {
    Function update;
    if (hint == "Name") {
      update = updateName;
    } else if (hint == "Link") {
      update = updateLink;
    } else if (hint == 'Notes') {
      update = updateNotes;
    }
    return EditNoteInput(
      hint: hint,
      initialVal: val,
      update: update,
    );
  }

  Widget _buildFormTitles(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: title == "CATEGORIES"
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 3,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    print(categoryList);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      color: Theme.of(context).primaryColor,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DropdownButton(
                      hint: Text('CATEGORY',
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                      value: selectedCategory,
                      items: categoryList.map((val) {
                        return DropdownMenuItem(
                          value: val.toString(),
                          child: Text(
                            val.toString(),
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (dynamic val) {
                        print(val);
                        print(selectedCategory);
                        updateCategory(val);
                      },
                    ),
                    nullCategory
                        ? Text(
                            'Please select a category',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Muli',
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
            SizedBox(height: height * 0.045),
            _buildTextSections('Name', note['title']),
            SizedBox(height: height * 0.03),
            _buildTextSections('Link', note['link']),
            SizedBox(height: height * 0.03),
            _buildTextSections('Notes', note['notes']),
            SizedBox(height: height * 0.045),
            _buildFormTitles("IMAGE", context),
            SizedBox(height: height * 0.025),
            ImageInput(updateImage: updateImage),
          ],
        ),
      ),
    );
  }
}
