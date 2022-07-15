import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/dialogues/newWorkOrder.dart';
import 'package:myproject/screens/pages/functionscreen/bodies/functioninfo.dart';
import 'package:myproject/screens/pages/functionscreen/bodies/history.dart';

import 'bodies/workorder.dart';

class FunctionPage extends StatefulWidget {
  var fNum;


   FunctionPage(this.fNum,{Key? key}) : super(key: key);

  @override
  _FunctionPageState createState() => _FunctionPageState(fNum);
}

class _FunctionPageState extends State<FunctionPage> {
  var fNum;

  Color infoColor = Colors.blue;
  Color woColor = Colors.black;
  Color hisColor = Colors.black;

  MyProjectAppConstants constants = MyProjectAppConstants();
  late Box userInfo;
  var username;
  var password;
  var server;
  var function = {};
  late Widget showing;

  _FunctionPageState(this.fNum);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showing = FunctionInfo(fNum,function,goto: updateState);
    userInfo = Hive.box(constants.userBox);
    username = userInfo.get(constants.usernameKey);
    password = userInfo.get(constants.passKey);
    server= userInfo.get(constants.serverKey);

    GetData getData = GetData(password: password, username: username, url: "http://${server}/getFunctionData.php");
    getData.getFunctionData(fNum["heirachy"],fNum['function'])
        .then((value) {
          function = value;
          setState(() {
            showing = FunctionInfo(fNum,function,goto: updateState);
          });
    })
        .onError((error, stackTrace) {
          print(error);

    });

  }

   updateState(){
     setState(() {
      showing = FunctionWorkOrders(function);
      infoColor = Colors.black;
      woColor = Colors.blue;
      hisColor = Colors.black;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Function"),
        centerTitle: true,
        backgroundColor: Colors.black12,
        elevation: 0.0,
      ),
      floatingActionButton: TextButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return NewWorkOrder(function,updateInfo);
              });
        },
        child: Text("Create New\nWork Order"),
      ),
      body: Scaffold(
          appBar:AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: (){
                      setState(() {
                        showing = FunctionInfo(fNum, function,goto: updateState);
                        infoColor = Colors.blue;
                        woColor = Colors.black;
                        hisColor = Colors.black;
                      });
                    },
                    child: Text(
                        "Information",
                      style: TextStyle(
                          color: infoColor
                      ),
                    )
                ),
                TextButton(
                    onPressed: (){
                      setState(() {
                        showing = FunctionWorkOrders(function);
                        infoColor = Colors.black;
                        woColor = Colors.blue;
                        hisColor = Colors.black;
                      });
                    },
                    child: Text(
                        "Work Orders",
                      style: TextStyle(
                          color: woColor
                      ),
                    )
                ),
                TextButton(
                    onPressed: (){
                      setState(() {
                        showing = FunctionHistory(function);
                        infoColor = Colors.black;
                        woColor = Colors.black;
                        hisColor = Colors.blue;
                      });
                    },
                    child: Text(
                        "History",
                    style: TextStyle(
                      color: hisColor
                    ),)
                )
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            toolbarHeight: 20,
            elevation: 0.0,
          ),
          body: showing
      )
    );
  }
  updateInfo(){
    GetData getData = GetData(password: password, username: username, url: "http://${server}/getFunctionData.php");
    getData.getFunctionData(fNum["heirachy"],fNum['function'])
        .then((value) {
      function = value;
      setState(() {
        showing = FunctionInfo(fNum,function,goto: updateState);
      });
    })
        .onError((error, stackTrace) {
      print(error);

    });
  }
}
