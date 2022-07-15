import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/timeshhetbody/timesheetgrid.dart';

class TimeSheetBody extends StatefulWidget {
  const TimeSheetBody({Key? key}) : super(key: key);

  @override
  _TimeSheetBodyState createState() => _TimeSheetBodyState();
}

class _TimeSheetBodyState extends State<TimeSheetBody> {
  String clkIn = "Clocked In";
  String clkOut = "Clocked Out";
  MyProjectAppConstants constants = MyProjectAppConstants();

  late String username;
  late String password;
  late String server;
  bool ckIn = false;
  var t={};
  var timesheet = [];
  var timesheet24 = [];

  String stringCK(){
    if (ckIn){
      return clkIn;
    }else{
      return clkOut;
    }
  }

  Color? colorCk(){
    if (ckIn){
      return Colors.green[700];
    }else{
      return Colors.red[800];
    }
  }
  getTimeSheet(){
    GetData getData = GetData(username: username,password: password,url: "http://${server}/getTimeSheet.php");
    getData.getTimeSheet().then((value){
      //t = value['currentStatus'];
      if(value['ClockedStatus'] == "Clocked In"){
        setState(() {
          ckIn = true;
          timesheet = value['timesheet'];
          timesheet24 = value['time24'];
        });
      }else if(value['ClockedStatus'] == "Clocked Out"){
        setState(() {
          ckIn = false;
          timesheet = value['timesheet'];
          timesheet24 = value['time24'];
        });
      }
    }).onError((error, stackTrace) => null);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Box userBox = Hive.box(constants.userBox);
    username = userBox.get(constants.usernameKey);
    password = userBox.get(constants.passKey);
    server = userBox.get(constants.serverKey);
    getTimeSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 90.0,
                  onPressed:(){
                    if(ckIn){
                      GetData data = GetData(password: password, username: username, url: "http://${server}/clockOut.php");
                      data.clockOut(t).then((value){
                        if (value['ClockedStatus']){
                          setState(() {
                            ckIn = false;
                          });
                          getTimeSheet();
                        }
                      }).onError((error, stackTrace) => null);
                    }else{
                      GetData data = GetData(username: username,password: password,url: "http://${server}/clockIn.php");
                      data.clockIn().then((value) {
                        if(value['ClockedStatus']){
                          t= value['timesheet'];
                          setState(() {
                            ckIn = true;
                          });
                          getTimeSheet();

                        }
                      }).onError((error, stackTrace) => null);
                    }

                  },
                  icon: Center(
                    child: Icon(Icons.access_time,
                    color: colorCk(),
                    ),
                  )
                ),
                Text(
                  stringCK(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold

                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: TimeSheetGrid(timesheet,timesheet24),
                ),
              )
          )
        ],
    );
  }
}
