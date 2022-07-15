import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:myproject/main.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int counter = 0;
  late String username;
  String _username = "";



  List<Widget> co(){

    List<Widget> st = [
      Text("The number of refreshes is"),
      Text(counter.toString()),];
    return st;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = "";
  }
  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Testing",
          style: TextStyle(
            color: Colors.black,
          ),),
        centerTitle: true,
        toolbarHeight: 30.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          EditableText(
            onChanged: (String d){
              _username = d;
            },
            controller: TextEditingController(),
            focusNode: FocusNode(),
            style: TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.red,
            backgroundCursorColor: Colors.blue,

          ),
          TextButton(onPressed: ()  {
            DateTime day = DateTime.now();
            DateTime day1 = DateTime(2022,3,5,10,0,0);
            Duration diff = day1.difference(day);
            setState(() {
                username = diff.toString();
            });
/*            CupertinoDialogRoute(
                context: context,
                builder: (BuildContext context){
                  return Dialog(
                    child: Container(
                        child: Column(
                          children: [
                            Text("hello"),
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text("clear"))
                        ])
              ),
                  );}
              );*/
          }
              ,
              child: Text("Press me")
          ),
          Text(username.toString()),

        ],
      ),
    );
  }
}

