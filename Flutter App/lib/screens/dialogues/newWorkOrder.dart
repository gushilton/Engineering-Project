import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';

import '../../classes/constants.dart';

class NewWorkOrder extends StatefulWidget {
  final dynamic function;
  final Function() update;
  const NewWorkOrder(this.function,this.update,{Key? key}) : super(key: key);

  @override
  _NewWorkOrderState createState() => _NewWorkOrderState(function: function,update: update);
}

class _NewWorkOrderState extends State<NewWorkOrder> {
  String _problem = "";
  String _action = "";
  String _jobName = "";
  DateTime? dueDate;
  late Box userInfo;
  late String username;
  late String password;
  late String server;
  var function;
  Function() update;
  MyProjectAppConstants constants = MyProjectAppConstants();
  _NewWorkOrderState({this.function,required this.update});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = Hive.box(constants.userBox);
    username = userInfo.get(constants.usernameKey);
    password = userInfo.get(constants.passKey);
    server = "http://${userInfo.get(constants.serverKey)}/newWorkOrder.php";
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        child:Column(
          children: [
            Expanded(
                flex: 1,
                child: Text("Job Name")),
            Expanded(
              flex: 1,
              child: EditableText(
                controller:TextEditingController(
                    text: _jobName
                ),
                focusNode:FocusNode(),
                style: TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.red,
                backgroundCursorColor: Colors.red,
                onChanged: (String change){
                  _jobName = change;
                },
              ),
            ),
            Expanded(
              flex: 1,
                child: Text("Problem")),
            Expanded(
              flex: 3,
              child: EditableText(
                controller:TextEditingController(
                    text: _problem
                ),
                focusNode:FocusNode(),
                style: TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.red,
                backgroundCursorColor: Colors.red,
                onChanged: (String change){
                  _problem = change;
                },
              ),
            ),
            Expanded(
                flex: 1,
                child:Text("Action")
            ),
            Expanded(
                flex: 3,
            child:EditableText(
              controller:TextEditingController(
                  text: _action
              ),
              focusNode:FocusNode(),
              style: TextStyle(
                color: Colors.black,

              ),
              cursorColor: Colors.red,
              backgroundCursorColor: Colors.red,
              onChanged: (String change){
                _action = change;
              },
            )
          ),
            Expanded(
                flex:1,
                child:TextButton(
                  onPressed: ()async{
                    dueDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    );
                  },
                  child: Text("Date Due"),
                )
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: (){
                    if(_action == "" || _problem == "" || dueDate == null || _jobName == ""){
                      Fluttertoast.showToast(
                          msg: "Missing input or inputs",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16,
                          textColor: Colors.black,
                          backgroundColor: Colors.white

                      );
                    }else{
                      GetData newWorkOrder = GetData(password: password, username: username, url: server);
                      newWorkOrder.newWorkOrder(_jobName,_problem, _action, dueDate,function['component']).then((value){
                        Fluttertoast.showToast(
                            msg: "Work Order created",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            fontSize: 16,
                            textColor: Colors.black,
                            backgroundColor: Colors.white

                        );
                        Navigator.pop(context);
                        update();
                      });
                    }
                  },
                  child: Text("Create Work Order")
              ),
            )
          ],
        )
      ),
    );
  }
}
