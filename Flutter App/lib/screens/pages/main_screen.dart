import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/settingsscreen.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String isShowing;
  MyProjectAppConstants constants = MyProjectAppConstants();
  late Box userInfo;
  late String fName;
  late String lName;
  late String rank;
  late String department;

  void info(){
    fName = userInfo.get(constants.fNameKey) ?? "";
    lName = userInfo.get(constants.lNameKey) ?? "";
    rank = userInfo.get(constants.rankKey)??"";
    department = userInfo.get(constants.depKey)??"";
  }


 @override
  void dispose() {
    // TODO: implement dispose
   Hive.close();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = Hive.box(constants.userBox);
    isShowing = constants.homestring;
    info();
    Box filterBox = Hive.box(constants.filteringBox);
    if (userInfo.get(constants.usernameKey)==null){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen())
      );
    }
    GetData getData = GetData(username: userInfo.get(constants.usernameKey),password: userInfo.get(constants.passKey),url: userInfo.get(constants.serverKey));
    getData.getRoles().then((value) {
      filterBox.put("roles",value['crewRoles']);
    }).onError((error, stackTrace){
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(isShowing),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer:Drawer(
          child: Column(
            children: [
              Container(
                height: 150.0,
                color: Colors.grey,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                          Icons.directions_boat_filled,
                          size: 40.0,
                          color: Colors.blueAccent,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Name:"),
                          Text(fName),
                          Text(lName)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Department"),
                          Text(department),
                          Text("Rank"),
                          Text(rank)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    isShowing = constants.homestring;
                  });
                },
                child: Text(constants.homestring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    isShowing = constants.timesheetstring;
                  });
                },
                child: Text(constants.timesheetstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
              ),
        /*      TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    isShowing = constants.accountstring;
                  });
                },
                child: Text(constants.accountstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
              ),*/

              Divider(),
/*              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    isShowing = constants.stockstring;
                  });
                },
                child: Text(constants.stockstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
              ),*/
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    isShowing = constants.workorderstring;
                  });
                },
                child: Text(constants.workorderstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    constants.sortby;
                    isShowing = constants.defectsstring;
                  });
                },
                child: Text(constants.defectsstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    constants.sortby;
                    isShowing = constants.functionstring;
                  });
                },
                child: Text(constants.functionstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Divider(),

              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen())
                  ).then((r){
                    setState(() {
                      info();
                    });
                  });


                },
                child: Text(constants.settingsstring,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
              )
            ],
          )
      ),
      body:screenShowing(),
    );
  }

  Widget screenShowing(){
    Widget showing = constants.homebody;
    if (isShowing == constants.homestring){
      showing = constants.homebody;
    }else if (isShowing == constants.timesheetstring){
      showing = constants.timesheetbody;
    }else if(isShowing == constants.workorderstring){
      showing = constants.workorderbody;
    }else if (isShowing == constants.defectsstring){
      showing = constants.defectbody;
    }else if(isShowing == constants.functionstring){
      showing = constants.functionbody;
    }else if(isShowing == constants.accountstring){
      showing = constants.accountbody;
    }
     return showing;
  }

}
