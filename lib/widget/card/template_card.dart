import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'interface_controlableWidget.dart';
import '../note_action.dart';

class TemplateCard extends StatefulWidget
    implements InterFaceControllableWidget {
  TemplateCard({super.key});

  @override
  State<TemplateCard> createState() => _TemplateCardState();

  @override
  Widget? child;

  @override
  Color? color = Colors.white;

  @override
  bool? debug;

  @override
  bool? dragAble;

  @override
  InterFaceControllableWidget? fatherWidget;

  @override
  Color? fontColor;

  @override
  double? fontSize;

  @override
  double? height;

  @override
  String? name;

  @override
  Paint? paint;

  @override
  Offset scrollOffset = Offset.zero;

  @override
  double? width;

  @override
  ListenerRegisterHandler listenerRegister = ListenerRegisterHandler();

  @override
  List<EventRegisterHandler> eventHandlerList = [];


}

class _TemplateCardState extends State<TemplateCard> {
  Offset? lastDot;

  void cardRunEventByButton(ListenerType listenerType, event) {
    widget.listenerRegister.run(listenerType, event.buttons, event);
    setState(() {});
  }

  void cardRunListenerType(ListenerType listenerType, event) {
    widget.listenerRegister.runListenerType(listenerType, event);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return CustomListener(listenerRegister: widget.listenerRegister,);
    return RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          setState(() {
            for (EventRegisterHandler element in widget.eventHandlerList) {
              element.isAltPressed = event.isAltPressed;
              element.isControlPressed =event.isControlPressed;
              element.isMetaPressed = event.isMetaPressed;
              element.isShiftPressed = event.isShiftPressed;
              element.run(event);
              // element.runWithMatch(event);
            }

            // switch (event.logicalKey.keyLabel) {
            //   case "Z":
            //   if (event is RawKeyDownEvent) {
            //     if (event.isControlPressed && event.isShiftPressed) {
            //       print("重做");
            //     } else if (event.isControlPressed) {
            //       print("撤销");
            //     }
            //   }
            //
            //
            //     break;
            //   default:
            //     // print(event);
            // }
          });
        },
        child: Listener(
            onPointerDown: (event) {
              cardRunEventByButton(ListenerType.onPointerDown, event);
            },
            onPointerMove: (event) {
              cardRunEventByButton(ListenerType.onPointerMove, event);
            },
            onPointerUp: (event) {
              cardRunEventByButton(ListenerType.onPointerUp, event);
            },
            onPointerHover: (event) {
              cardRunListenerType(ListenerType.onPointerHover, event);
            },
            onPointerCancel: (event) {
              cardRunEventByButton(ListenerType.onPointerCancel, event);
            },
            onPointerPanZoomStart: (event) {
              cardRunEventByButton(ListenerType.onPointerPanZoomStart, event);
            },
            onPointerPanZoomUpdate: (event) {
              cardRunEventByButton(ListenerType.onPointerPanZoomUpdate, event);
            },
            onPointerPanZoomEnd: (event) {
              cardRunEventByButton(ListenerType.onPointerPanZoomEnd, event);
            },
            onPointerSignal: (event) {
              cardRunEventByButton(ListenerType.onPointerSignal, event);
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              color: widget.color,
              child: widget.child,
            )));
  }
}
