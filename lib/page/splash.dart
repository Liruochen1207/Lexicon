import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lexicon/widget/card/template_card.dart';

import '../widget/card/interface_controlableWidget.dart';
import '../widget/note_action.dart';

void main() {
  runApp(
      MaterialApp(
        home: SplashPage(),
      )
  );
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late TemplateCard card;

  void getStart() {
    Navigator.pushReplacementNamed(context, '/books');
  }

  @override
  void initState() {
    super.initState();
    card = TemplateCard();
    card.requestFocus();
    EventRegisterHandler eventRegisterHandler = EventRegisterHandler();
    eventRegisterHandler.setHandler(() {
      getStart();
    });
    card.color = Color(0xFF282625);
    card.eventHandlerList.add(eventRegisterHandler);
    card.listenerRegister.addListener(
        ListenerType.onPointerMove, NoteButtonAction.leftButton, (event) {
      getStart();
    });
    card.child = Container(
      // color: Color(0xFF282625),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.transparent, Color(0x28282625), Color(0x62282625), Color(
                0xAD282625), Colors.black, Colors.black],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          'assets/images/book_shelves.png',
          colorBlendMode: BlendMode.lighten,
          color: Color(0xFF282625),
          fit: BoxFit.cover,
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return card;
  }
}
