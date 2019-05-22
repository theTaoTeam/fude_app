import 'package:flutter/material.dart';
import 'package:fude/models/idea.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fude/widgets/forms/edit_note_form_container.dart';
import 'package:fude/pages/notes/note.dart';
import 'package:fude/pages/jars/jar_notes.dart';
import 'package:fude/scoped-models/main.dart';
import 'dart:io';

class NoteEditPage extends StatefulWidget {
  final Idea idea;


  NoteEditPage({this.idea});

  @override
  State<StatefulWidget> createState() {
    return _AddNotePageState();
  }
}

class _AddNotePageState extends State<NoteEditPage> {
  String selectedCategory;
  String selectedJar;
  bool nullCategory = false;

  final Map<String, dynamic> _formData = {
    'category': '',
    'title': '',
    'link': '',
    'notes': '',
    'image': null,
  };

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCategory = widget.idea.category;
    });
  }

  void updateNote(MainModel model) {
    // First validate form.
    if (!this.formKey.currentState.validate()) {
      return;
    } else {
      formKey.currentState.save(); // Save our form now.
      model.updateNote(widget.idea, _formData['category'], _formData['title'],
          _formData['notes'], _formData['link'], _formData['image']);
      Navigator.pushReplacement(
        context,
        PageTransition(
          curve: Curves.linear,
          type: PageTransitionType.fade,
          child: JarNotes(model: model),
        ),
      );
    }
  }

  void updateCategory(dynamic value) {
    print("updating cateogory: $value");
    setState(() {
      selectedCategory = value;
      _formData['category'] = value.toString();
    });
  }

  void updateName(String value) {
    setState(() {
      _formData['title'] = value;
    });
  }

  void updateLink(String value) {
    setState(() {
      _formData['link'] = value;
    });
  }

  void updateNotes(String value) {
    setState(() {
      _formData['notes'] = value;
    });
  }

  void updateImage(File image) {
    print(image);
    setState(() {
      _formData['image'] = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 25),
              icon: Icon(Icons.keyboard_arrow_down),
              color: Theme.of(context).iconTheme.color,
              iconSize: Theme.of(context).iconTheme.size,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      curve: Curves.linear,
                      type: PageTransitionType.upToDown,
                      child: NotePage(
                        idea: widget.idea,
                        isRandom: false,
                      ),
                    ),
                  ),
            )
          ],
        ),
        body: Container(
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    EditNoteForm(
                      formKey: formKey,
                      idea: widget.idea,
                      categoryList: model.selectedJar.data['categories'],
                      nullCategory: nullCategory,
                      selectedCategory: selectedCategory,
                      updateCategory: updateCategory,
                      updateName: updateName,
                      updateLink: updateLink,
                      updateNotes: updateNotes,
                      updateImage: updateImage,
                    ),
                    SizedBox(height: height * 0.04),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.045, 0, width * 0.045, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text(
                              'UPDATE IDEA',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 5,
                              ),
                            ),
                            elevation: 7,
                            highlightElevation: 1,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Theme.of(context).secondaryHeaderColor,
                            splashColor: Colors.transparent,
                            highlightColor: Theme.of(context).primaryColor,
                            onPressed: () => updateNote(model),
                          ),
                          IconButton(
                              icon: Icon(Icons.delete),
                              iconSize: 36,
                              color: Colors.red,
                              onPressed: () {
                                model.deleteJarIdea(widget.idea.id, widget.idea.title);
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      curve: Curves.linear,
                                      type: PageTransitionType.upToDown,
                                      child: JarNotes(model: model)),
                                );
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      );
    });
  }
}
