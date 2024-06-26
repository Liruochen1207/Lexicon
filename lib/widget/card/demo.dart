
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lexicon/widget/card/paint_board.dart';

import 'package:lexicon/widget/card/template_card.dart';

import 'interface_controlableWidget.dart';
import '../note_action.dart';



void main()  {
  CustomBoard customBoard = CustomBoard();
  customBoard.setBackGroundColor(Color(0xff363535));

  EventRegisterHandler revokeHandler = EventRegisterHandler(LogicalKeyboardKey.keyZ);
  revokeHandler.setHandler((){
    // if (CustomBoard.strokes != [])
    if (revokeHandler.isControlPressed && !revokeHandler.isShiftPressed){
      customBoard.undo();
    } else if (revokeHandler.isControlPressed && revokeHandler.isShiftPressed){
      customBoard.redo();
    }


  });
  revokeHandler.setOnlyKeyDownAlive();


  TemplateCard templateCard = TemplateCard()
  ..child=customBoard

  ..listenerRegister.addListener(ListenerType.onPointerMove, NoteButtonAction.leftButton, (event) {

    })
    ..listenerRegister.addListener(ListenerType.onPointerMove, NoteButtonAction.leftButton, (event) {

    })
  ..eventHandlerList.add(revokeHandler);

  runApp(templateCard);
}
