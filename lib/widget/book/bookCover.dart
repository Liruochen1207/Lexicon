import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexicon/widget/card/template_card.dart';

import '../card/interface_controlableWidget.dart';
import '../note_action.dart';

class BookCover extends StatelessWidget {
  var bookCoverHeight;

  var bookCoverWidth;

  BookCover(
      {super.key, required this.bookCoverHeight, required this.bookCoverWidth});

  @override
  Widget build(BuildContext context) {
    return TemplateCard()
      ..child = Stack(
        children: [

          Container(
            color: Colors.white,
            height: bookCoverHeight,
            width: bookCoverWidth,
          ),

          Positioned(
            child: Container(
              color: Color(0xFFAD4A15),
              child: Text("Book", style: TextStyle(color: Colors.white, fontSize: 23),),
              height: bookCoverHeight,
              width: bookCoverWidth-3,
            ),
          ),

          Container(
            height: bookCoverHeight,
            width: bookCoverWidth,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3D1A00).withOpacity(0.7), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.6), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.5), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.4), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.1), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.09), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.06), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.03), // 上部阴影效果
                  Color(0xFF3D1A00).withOpacity(0.01), // 上部阴影效果
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xFFE8C75B).withOpacity(0.02), // 上部阴影效果
                  Color(0xFFE8C75B).withOpacity(0.1), // 上部阴影效果
                  Color(0xFFE8C75B).withOpacity(0.05), // 上部阴影效果
                ],
              ),
            ),
            // 其他Container属性...
          ),


        ],
      )
      ..listenerRegister.addListener(ListenerType.onPointerDown, NoteButtonAction.leftButton, (event) {
        Navigator.pushReplacementNamed(context, '/paper');
      })
    ;
  }
}
