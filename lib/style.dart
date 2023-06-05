import 'package:flutter/material.dart';

var themes = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 2,
        selectedItemColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
        actionsIconTheme: IconThemeData(color: Colors.black)
    ),
    textTheme: TextTheme(
        bodyText2: TextStyle(color: Colors.black)
    ),
);