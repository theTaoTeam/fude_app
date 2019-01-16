import 'package:flutter/material.dart';

import 'package:fude/scoped-models/main.dart';
import 'package:fude/pages/recipes/allrecipes/all_recipes_list.dart';

Widget buildSideDrawer(BuildContext context, MainModel model) {
  return Drawer(
    child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/larry.jpg'),
          ),
          accountName: Text('füde'),
          accountEmail: Text('powered by Tao Team'),
        ),
        Container(
          child: ListTile(
            title: Text('home'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ),
        Container(
          child: ListTile(
            title: Text('logout'),
            onTap: () => model.logout(),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RecipeListPage(model),
          ],
        )
      ],
    ),
  );
}
