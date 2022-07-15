import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/functionscreen/functionpage.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/functionbody/menuBuilder.dart';

class FunctionHeirachyBody extends StatefulWidget {
  const FunctionHeirachyBody({Key? key}) : super(key: key);

  @override
  _FunctionHeirachyBodyState createState() => _FunctionHeirachyBodyState();
}

class _FunctionHeirachyBodyState extends State<FunctionHeirachyBody> {

  List<Widget> showing = [];
  late Box userBox;
  MyProjectAppConstants constants = MyProjectAppConstants();
  late String username;
  late String password;
  late String server;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box(constants.userBox);
    username = userBox.get(constants.usernameKey);
    password = userBox.get(constants.passKey);
    server = userBox.get(constants.serverKey);
    GetData data = GetData(password: password, username: username, url: "http://${server}/functionHierachy.php");
    data.getHeirachy().then((value){
      value = value['response'];
      List<Widget> toShow = [];
      for (int i = 0; i<value['Division1'].length;i++){
        toShow.add(Menu1Builder(value['Division1'][i], value['Division2'][i], value['Division3'][i]));
      }
      setState(() {
        showing = toShow;
      });
    }).onError((error, stackTrace) => null);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: showing
          ),
        ),
      ),
    );
  }


}


