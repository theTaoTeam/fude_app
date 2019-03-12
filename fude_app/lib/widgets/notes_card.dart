import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fude/pages/home/notes/notes_edit.dart';
import 'package:fude/scoped-models/main.dart';

class NotesCard extends StatelessWidget {
  final DocumentSnapshot note;
  final MainModel model;

  NotesCard({this.note, this.model});

  Widget _buildCategoryTitleRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(note['category'], style: TextStyle(fontWeight: FontWeight.bold)),
          Text(note['title'])
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, DocumentSnapshot note) {
    return ButtonBar(
        mainAxisSize: MainAxisSize.min,
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            iconSize: 20,
            icon: Icon(Icons.info),
            color: Theme.of(context).accentColor,
            onPressed: () {
              print('icon pressed');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NotesEditPage();
                  },
                ),
              );
            },
          ),
          IconButton(
            iconSize: 20,
            icon: note.data['isFav'] != false
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              print('trying to favorite');
              model.toggleFavoriteStatus(note);
            },
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth =
        deviceWidth > 550.0 ? 100.0 : deviceWidth * 0.45;
    return Card(
      child: Row(
        children: <Widget>[
          FadeInImage(
            image: note['image'] != null
                ? NetworkImage(note['image'])
                : NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/fude-app.appspot.com/o/Scoot-01.png?alt=media&token=aec9a64b-6269-4751-bbec-fdd7016d8f47',
                    scale: 0.1),
            height: 100.0,
            width: _targetWidth,
            fit: BoxFit.contain,
            placeholder: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/fude-app.appspot.com/o/Scoot-01.png?alt=media&token=aec9a64b-6269-4751-bbec-fdd7016d8f47',
                    scale: 0.1),
          ),
          Column(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  _buildCategoryTitleRow(),
                ],
              ),
              _buildActionButtons(context, note),
            ],
          )
        ],
      ),
    );
  }
}
