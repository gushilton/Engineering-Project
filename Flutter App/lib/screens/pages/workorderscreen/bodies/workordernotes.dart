import 'package:flutter/material.dart';

class WorkOrderNotes extends StatelessWidget {
  var workNotes;
  WorkOrderNotes(this.workNotes,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> note = [];
    for (int i = 0; i < workNotes.length;i++){
      note.add(Divider(thickness: 5));
      note.add(Text("${workNotes[i]['DateTime']}\n${workNotes[i]['Note']}"));
      note.add(Divider(thickness: 5));
    }
    return Container(
      child: Column(
        children: note,
      ),
    );
  }
}
