import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/constants.dart';

import '../../classes/api_request.dart';

class UpdateDialogue extends StatefulWidget {
  var workOrder;
  Function() refresh;
  UpdateDialogue(this.workOrder,this.refresh,{Key? key}) : super(key: key);

  @override
  _UpdateDialogueState createState() => _UpdateDialogueState(workOrder,refresh);
}

class _UpdateDialogueState extends State<UpdateDialogue> {
  var workOrder;
  Function() refresh;
  bool _addNote = true;
  bool _complete  = true;
  String _note = "";
  _UpdateDialogueState(this.workOrder,this.refresh);
  late Box userBox;
  MyProjectAppConstants constants = MyProjectAppConstants();
  @override
  void initState() {
    // TODO: implement initState
    userBox = Hive.box(constants.userBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        child: Column(

          children: [
            Expanded(
              flex:1,
              child: Row(
                children: [
                  Expanded(
                      flex:1,
                      child: Text("Add Note")
                  ),
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                        value: _addNote,
                        onChanged: (addNote){
                          setState(() {
                            _addNote = addNote!;
                          });
                        }
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                onChanged: (notes){
                  setState(() {
                    _note = notes;
                  });
                },
              ),
            ),

            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex:1,
                      child: Text("Complete")),
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                        value: _complete,
                        onChanged: (complete){
                          setState(() {
                            _complete = complete!;
                          });
                        }
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: (){
                        String username = userBox.get(constants.usernameKey);
                        String password = userBox.get(constants.passKey);
                        String server = userBox.get(constants.serverKey);
                        Map up = {"complete":_complete,"addNote":_addNote};
                        GetData update = GetData(password: password, username: username, url: "http://${server}/updateTask.php");
                        update.updateWorkOrder(workOrder,_note,up).then((value){
                          refresh();
                          Navigator.pop(context);
                        });

                      },
                      child: Text("Update Order")
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
