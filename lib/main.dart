import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexicon/page/bookshelf.dart';
import 'package:lexicon/page/paper.dart';
import 'package:lexicon/page/splash.dart';


void main() {
  runApp(
      MaterialApp(
        home: BookShelvesPage(),
        routes: {
          '/splash': (context) => SplashPage(),
          '/books': (context) => BookShelvesPage(),
          '/paper': (context) => PaperPage(),
        },
      )
  );
}