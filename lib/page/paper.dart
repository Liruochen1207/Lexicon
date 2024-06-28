import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http.dart';
import '../widget/card/interface_controlableWidget.dart';
import '../widget/card/template_card.dart';
import '../widget/note_action.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<PaperPage> createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage> {
  late TemplateCard innerPaper;
  var currentTable = 0;
  var currentPage = 0;
  var delta = 0;
  String currentText = "";

  Future<void> getNote() async {
    var data = await novelData(currentTable, currentPage);
    if (data[0] != "error"){
      currentText =  data[1];
    } else {
      currentTable += 1;
      currentPage = 0;
      getNote();
    }

    // print(currentText);
    setState(() {

    });
  }

  Widget buildCard() {
    innerPaper = TemplateCard();
    innerPaper.child = Align(alignment: Alignment.topLeft,child: Text(currentText),);
    innerPaper.color = Color(0xffd9cfba);
    innerPaper.requestFocus();
    innerPaper.listenerRegister.addListener(ListenerType.onPointerMove, NoteButtonAction.leftButton, (event) {
      if (event.delta.dx < 0) {
        delta += 1;
      }
      if (event.delta.dx > 0) {
        delta -= 1;
      }

    });
    innerPaper.listenerRegister.addListener(ListenerType.onPointerUp, NoteButtonAction.leftButton, (event) {

      // if (delta < 0) {
      //   print("page -");
      //   currentPage -= 1;
      // } else {
      //   print("page +");
      //   currentPage += 1;
      // }
      // getNote();
      // delta = 0;

    });
    return innerPaper;
  }

  @override
  void initState() {
    super.initState();
    getNote();



  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xffbda25e), actions: [
          Text("页数: $currentPage")
        ],
        ),
        body: buildCard(),
      ),
    );
  }
}
