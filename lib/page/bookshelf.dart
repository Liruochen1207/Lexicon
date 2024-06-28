import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/book/bookCover.dart';

class BookShelvesPage extends StatefulWidget {
  BookShelvesPage({super.key});
  List<double> baseLine_Ratios = [0.235, 0.415, 0.598, 0.782];
  double bookHeight_Ratio = 0.14;
  double bookWidth_Ratio = 0.1;

  get baseLineLength => baseLine_Ratios.length;

  @override
  State<BookShelvesPage> createState() => _BookShelvesPageState();
}

class _BookShelvesPageState extends State<BookShelvesPage> {
  get screenSize => MediaQuery.of(context).size;

  get screenHeight => screenSize.height;

  get screenWidth => screenSize.width;

  List<Widget> buildBookCover() {
    List<Widget> background = [
      Positioned(
        child: ColoredBox(color: Color(0xFFD59E57)),
        width: screenWidth,
        height: 20,
        top: 0,
      ),
      Positioned(
        child: Image.asset(
          // width: screenWidth as double,
          height: screenWidth as double,
          'assets/images/Bookshelf.jfif',
          repeat: ImageRepeat.repeatY,
          fit: BoxFit.fill,
        ),
        left: 0,
        right: 0,
        top: 7,
        bottom: 0,
      ),
    ];
    for (int i = 0; i < widget.baseLineLength; i++) {
      double ratio = widget.baseLine_Ratios[i];
      var bookCoverWidth = screenHeight * widget.bookWidth_Ratio;
      var bookCoverHeight = screenHeight * widget.bookHeight_Ratio;
      var startLine = (screenWidth / 3 - bookCoverWidth) / 2;
      var split = screenWidth / 3;
      for (int i = 0; i < 2; i++) {
        var yield = Positioned(
          child: BookCover(bookCoverHeight: bookCoverHeight, bookCoverWidth: bookCoverWidth,),
          bottom: (screenHeight - 7) * ratio,
          left: startLine,
        );
        startLine += split;
        background.add(yield);
      }
    }
    return background;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buildBookCover(),
    );
  }
}
