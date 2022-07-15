import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/functionbody/functionBuilder.dart';

class Menu3Builder extends StatefulWidget {
  var div;
  Menu3Builder(this.div,{Key? key}) : super(key: key);

  @override
  _Menu3BuilderState createState() => _Menu3BuilderState(div);
}

class _Menu3BuilderState extends State<Menu3Builder> {
  bool showChildren = false;
  MyProjectAppConstants constants = MyProjectAppConstants();
  var div;
  var functions;
  _Menu3BuilderState(this.div);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var function;
    Box userBox = Hive.box(constants.userBox);
    GetData getData = GetData(password: userBox.get(constants.passKey), username: userBox.get(constants.usernameKey), url: "http://${userBox.get(constants.serverKey)}/getFunction.php");
    if (div['Division3']==''){
      function = "${div['Division1']}${div['Division2']}";
    }else{
      function = "${div['Division1']}${div['Division2']}${div['Division3']}";
    }
    getData.getFunctions(function).then((value) {
      setState(() {
        functions = value;
      });
    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> show = [];
    if(div['Division3']!='') {
      show.add(
        Row(
          children: [
            SizedBox(width: 30,),
            TextButton(
                onPressed: () {
                  setState(() {
                    showChildren = !showChildren;
                  });
                },
                child: Text(
                  "${div['Division1'] ?? ""}${div['Division2'] ??
                      ""}${div['Division3'] ?? ""}-${div["DivisionName"] ??
                      ""}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                  ),
                )
            ),
          ],
        ),
      );
      if (showChildren) {
        if (functions != null ){
          for(int i = 0;i<functions!.length;i++){
            show.add(FunctionBuilder(functions[i]));
          }
        }
      }
    }else{
      if (functions != null ){
        for(int i = 0;i<functions!.length;i++){
          show.add(FunctionBuilder(functions[i]));
        }
      }
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: show
    );
  }
}