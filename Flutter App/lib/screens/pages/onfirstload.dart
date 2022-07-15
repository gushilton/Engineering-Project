import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myproject/main.dart';

class OnFirstLoad extends StatefulWidget {
  const OnFirstLoad({Key? key}) : super(key: key);

  @override
  _OnFirstLoadState createState() => _OnFirstLoadState();
}

class _OnFirstLoadState extends State<OnFirstLoad> {

  late String _response;
  late String _username;
  late String _password;
  late String _server;
  MyProjectAppConstants constants = MyProjectAppConstants();
  late Box userInfo;

  @override
  void initState() {
    // TODO: implement initState
    _response = "";
    userInfo = Hive.box(constants.userBox);
    _username = userInfo.get(constants.usernameKey) ??"";
    _server = userInfo.get(constants.serverKey) ?? "";
    _password = userInfo.get(constants.passKey) ?? "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),

            child: Column(
              children: [
                Text("Login"),
                Text("username"),
                EditableText(

                  controller:TextEditingController(
                      text: _username
                  ),
                  focusNode:FocusNode(),
                  style: TextStyle(
                    color: Colors.black,

                  ),
                  cursorColor: Colors.red,
                  backgroundCursorColor: Colors.red,
                  onChanged: (String change){
                    _username = change;
                  },
                ),
                Text("Password"),
                EditableText(
                  controller:TextEditingController(
                      text: _password
                  ),
                  focusNode:FocusNode(),
                  style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.black12
                  ),
                  cursorColor: Colors.red,
                  backgroundCursorColor: Colors.red,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  onChanged: (pswd){
                    _password = pswd;
                  },
                ),
                Divider(),
                Text("Server"),
                EditableText(
                  controller:TextEditingController(
                      text: _server
                  ),
                  focusNode:FocusNode(),
                  style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.black12
                  ),
                  cursorColor: Colors.red,
                  backgroundCursorColor: Colors.red,
                  onChanged: (change){
                    _server = change;
                  },
                ),
                Divider(),
                TextButton(onPressed: (){


                  if (_username != "" && _server != "") {
                    GetData login = GetData(password: _password, username: _username, url: "http://${_server}/userLogin.php");
                    login.login().then((response) async {
                      userInfo.put(constants.usernameKey, _username);
                      userInfo.put(constants.serverKey,_server);
                      userInfo.put(constants.passKey, _password);
                      userInfo.put(constants.fNameKey, response["fName"]);
                      userInfo.put(constants.lNameKey, response["lName"]);
                      userInfo.put(constants.depKey, response["department"]);
                      userInfo.put(constants.rankKey, response["rank"]);
                      Fluttertoast.showToast(
                          msg: "login Successfull",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16

                      );
                      main();

                    }).catchError((error){
                      Fluttertoast.showToast(
                          msg: "login Unsuccseful",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16,
                          textColor: Colors.black,
                          backgroundColor: Colors.white

                      );
                      userInfo.put(constants.usernameKey, _username);
                      userInfo.put(constants.serverKey,_server);
                      userInfo.put(constants.passKey, _password);
                      main();
                    });
                  }else{
                    if (_server == "" && _username != ""){
                      Fluttertoast.showToast(
                          msg: "No Server Address\nPlease Add a server address",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16,
                          textColor: Colors.black,
                          backgroundColor: Colors.white

                      );
                    }else if (_server != "" && _username == ""){
                      Fluttertoast.showToast(
                          msg: "No username\nPlease Add a username",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16,
                          textColor: Colors.black,
                          backgroundColor: Colors.white

                      );
                    }else{
                      Fluttertoast.showToast(
                          msg: "No username or server address\nPlease Add",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16,
                          textColor: Colors.black,
                          backgroundColor: Colors.white

                      );
                    }
                  }

                },
                    child: Text("Login")
                ),
                Divider(),
                Text(_response)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
