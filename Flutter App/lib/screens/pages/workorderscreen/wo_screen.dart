import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/workorderscreen/bodies/methodbody.dart';
import 'package:myproject/screens/pages/workorderscreen/bodies/workorderinfo.dart';
import 'package:myproject/screens/pages/workorderscreen/bodies/workordernotes.dart';

import '../../dialogues/updateDialogue.dart';

class WOScreen extends StatefulWidget {
  Map WOrder;
    WOScreen(this.WOrder,{Key? key}) : super(key: key);

  @override
  _WOScreenState createState() => _WOScreenState(WOrder);
}

class _WOScreenState extends State<WOScreen> {
  var workOrder;
  var taskNotes;
  late var isShowing;
  late Box userInfo;
  late String username;
  late String password;
  late String server;
  MyProjectAppConstants constants = MyProjectAppConstants();

  late Widget showw;
  _WOScreenState(this.workOrder){
    showw = WorkOrderInfo(workOrder);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isShowing = "info";
    userInfo = Hive.box(constants.userBox);
    username = userInfo.get(constants.usernameKey);
    password = userInfo.get(constants.passKey);
    server = userInfo.get(constants.serverKey);
    refresh();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Order\n${workOrder['yearID']??""}/${workOrder['JobID']}"),
        centerTitle: true,

      ),
      body: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 20.0,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){
                  setState(() {
                    showw = WorkOrderInfo(workOrder);
                  });
                },
                child: Text("Information"),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    showw = MethodBody(workOrder);
                  });

                },
                child: Text("Method"),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    showw = WorkOrderNotes(taskNotes);
                  });

                },
                child: Text("TaskNotess"),
              )
            ],
          ),

          iconTheme: IconThemeData(
              color: Colors.black,
              size: 15.0
          ),

        ),
        floatingActionButton: TextButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return UpdateDialogue(workOrder,refresh);
                });
          },
          child: Text("Update"),
        ),

        body: showw
      ),
    );
  }

  refresh() {
    GetData getWorkOrder = GetData(password: password, username: username, url: "http://${server}/getWorkOrder.php");
    getWorkOrder.getWorkOrderData(workOrder['yearID'], workOrder['JobID'])
        .then((value){
      isShowing = "information";
      setState(() {
        workOrder = value["workOrders"];
        showw = WorkOrderInfo(workOrder);
        taskNotes = value["taskNotes"];
      });


    })
        .onError((error, stackTrace) => null);
  }


}
