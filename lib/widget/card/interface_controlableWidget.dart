import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/rendering/proxy_box.dart';
import 'package:flutter/src/services/mouse_tracking.dart';

import '../note_action.dart';

interface class InterFaceControllableWidget {
  late Offset scrollOffset;
  InterFaceControllableWidget? fatherWidget;
  Widget? child;
  Color? color;
  Color? fontColor;
  double? fontSize;
  Paint? paint;
  bool? debug;
  bool? dragAble;
  double? height;
  double? width;
  String? name;
  late ListenerRegisterHandler listenerRegister;
  late List<EventRegisterHandler> eventHandlerList;
  // void Function()? callRefresh;
}

typedef ListenerAction = NoteButtonAction;

enum ListenerType {
  onPointerDown,
  onPointerMove,
  onPointerUp,
  onPointerHover,
  onPointerCancel,
  onPointerPanZoomStart,
  onPointerPanZoomUpdate,
  onPointerPanZoomEnd,
  onPointerSignal,
}

class EventRegisterHandler {
  late LogicalKeyboardKey _keyBind;
  bool _onKeyUp = false;
  bool _onKeyDown = true;
  bool isAltPressed = false;
  bool isControlPressed = false;
  bool isMetaPressed = false;
  bool isShiftPressed = false;
  void Function() _event = () {};

  EventRegisterHandler(LogicalKeyboardKey key) {
    _keyBind = key;
    setOnlyKeyDownAlive();
  }

  setHandler(void Function() handlerEvent) {
    _event = handlerEvent;
  }

  setBothKeyAlive() {
    _onKeyUp = true;
    _onKeyDown = true;
  }

  setBothKeyDeath() {
    _onKeyUp = false;
    _onKeyDown = false;
  }

  setOnlyKeyUpAlive() {
    _onKeyUp = true;
    _onKeyDown = false;
  }

  setOnlyKeyDownAlive() {
    _onKeyUp = false;
    _onKeyDown = true;
  }

  run(RawKeyEvent event) {
    if (event.logicalKey == _keyBind){
      if ((event is RawKeyDownEvent) && _onKeyDown){
        _event.call();
      }
      if ((event is RawKeyUpEvent) && _onKeyUp){
        _event.call();
      }
    }

  }


  // addKey(LogicalKeyboardKey key) {
  //   _keyBinds.add(key);
  // }
  // addKeys(List<LogicalKeyboardKey> keyList) {
  //   _keyBinds.addAll(keyList);
  // }
  //
  // clearKeyBind() {
  //   _keyBinds = [];
  // }





  // runWithMatch(RawKeyEvent event)  {
  //   if (isMatch(event)){
  //     run();
  //   }
  // }
  //
  // bool isMatch(RawKeyEvent event){
  //   if ((event is RawKeyDownEvent && !_onKeyDown)||(event is RawKeyUpEvent && !_onKeyUp)){
  //     return false;
  //   }
  //   if (_keyBinds.contains(event.logicalKey)){
  //     bool matched = true;
  //     for (var element in _keyBinds) {
  //       if (!event.isKeyPressed(element)){
  //         matched = false;
  //         break;
  //       }
  //     }
  //     if (matched){
  //       print(getDescription());
  //     }
  //     return matched;
  //   } else {
  //     return false;
  //   }
  //
  // }

  // String getDescription() {
  //   var description = "";
  //   var at = 0;
  //   var endStr = "+";
  //   for (var element in _keyBinds) {
  //     at ++;
  //     if (at == _keyBinds.length){
  //       endStr = "";
  //     }
  //     description+="${element.keyLabel}${endStr}";
  //
  //   }
  //   return description;
  // }
}

class ListenerRegisterHandler {
  Map<ListenerType, Map<int, List<void Function(PointerEvent event)>>>
      _listenerMap = {};

  void addListener(ListenerType listenerType, int listenerAction,
      void Function(PointerEvent event) listener) {
    if (_listenerMap[listenerType] == null) {
      _listenerMap[listenerType] = {
        listenerAction: [listener]
      };
    } else if (_listenerMap[listenerType]?[listenerAction] == null) {
      _listenerMap[listenerType]?[listenerAction] = [listener];
    } else {
      _listenerMap[listenerType]?[listenerAction]?.add(listener);
    }
  }

  void run(ListenerType listenerType, int listenerAction, PointerEvent event) {
    if (_listenerMap[listenerType]?[listenerAction] != null) {
      _listenerMap[listenerType]?[listenerAction]?.forEach((element) {
        element.call(event);
      });
    }
  }

  void runListenerType(ListenerType listenerType, PointerEvent event) {
    if (_listenerMap[listenerType] == null) {
    } else {
      _listenerMap[listenerType]?.forEach((key, value) {
        for (var element in value) {
          element.call(event);
        }
      });
    }
  }
}

// class CustomListener extends Listener {
//   ListenerRegister? listenerRegister;
//   late PointerCancelEventListener pointerCancelEvent;
//   late PointerDownEventListener pointerDownEvent;
//
//   CustomListener({super.key, required this.listenerRegister}){
//     pointerCancelEvent = (event){
//       listenerRegister?.runListenerType(ListenerType.onPointerCancel, event);
//     };
//     pointerDownEvent = (event){
//       listenerRegister?.runListenerType(ListenerType.onPointerDown, event);
//     };
//   }
//
//   // @override
//   // // TODO: implement behavior
//   // HitTestBehavior get behavior => throw UnimplementedError();
//   //
//   // @override
//   // // TODO: implement child
//   // Widget? get child => throw UnimplementedError();
//   //
//   // @override
//   // SingleChildRenderObjectElement createElement() {
//   //   // TODO: implement createElement
//   //   throw UnimplementedError();
//   // }
//   //
//   // @override
//   // RenderPointerListener createRenderObject(BuildContext context) {
//   //   // TODO: implement createRenderObject
//   //   throw UnimplementedError();
//   // }
//   //
//   // @override
//   // List<DiagnosticsNode> debugDescribeChildren() {
//   //   // TODO: implement debugDescribeChildren
//   //   throw UnimplementedError();
//   // }
//   //
//   // @override
//   // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   //   // TODO: implement debugFillProperties
//   // }
//   //
//   // @override
//   // void didUnmountRenderObject(covariant RenderObject renderObject) {
//   //   // TODO: implement didUnmountRenderObject
//   // }
//   //
//   // @override
//   // // TODO: implement key
//   // Key? get key => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerCancel
//   PointerCancelEventListener? get onPointerCancel => pointerCancelEvent;
//
//   @override
//   // TODO: implement onPointerDown
//   PointerDownEventListener? get onPointerDown => pointerDownEvent;
//
//   @override
//   // TODO: implement onPointerHover
//   PointerHoverEventListener? get onPointerHover => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerMove
//   PointerMoveEventListener? get onPointerMove => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerPanZoomEnd
//   PointerPanZoomEndEventListener? get onPointerPanZoomEnd => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerPanZoomStart
//   PointerPanZoomStartEventListener? get onPointerPanZoomStart => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerPanZoomUpdate
//   PointerPanZoomUpdateEventListener? get onPointerPanZoomUpdate => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerSignal
//   PointerSignalEventListener? get onPointerSignal => throw UnimplementedError();
//
//   @override
//   // TODO: implement onPointerUp
//   PointerUpEventListener? get onPointerUp => throw UnimplementedError();
//
//   // @override
//   // DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style}) {
//   //   // TODO: implement toDiagnosticsNode
//   //   throw UnimplementedError();
//   // }
//   //
//   // @override
//   // void updateRenderObject(BuildContext context, covariant RenderPointerListener renderObject) {
//   //   // TODO: implement updateRenderObject
//   // }
//
// }
