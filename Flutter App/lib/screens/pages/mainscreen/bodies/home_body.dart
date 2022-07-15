import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/workorderscreen/wo_screen.dart';


class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  late GetData getData;
  late Box userInfo;
  Map <String,List<Widget>> data = {"today":[],"week":[]};
  Map workOrders = {};
  MyProjectAppConstants constants = MyProjectAppConstants();
  String ckIN = "Clocked Out";
  var timesheetEntry = {};

  Widget rowBuilder(workOrder,jobName,function,component,assigned,dateDue,dateCreated){
    var height = 50.0;
    var txtColor = colorTXT(dateDue);
    Row row = Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            )
          ),
          child: SizedBox(
            width: 100,
            height: height,
            child: Center(
              child: Text(
                workOrder,
                style: TextStyle(
                  color: txtColor
                ),

              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: SizedBox(
            width: 200,
            height: height,
            child: Center(
              child: Text(
                  jobName,
                style: TextStyle(
                      color: txtColor
                  ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: SizedBox(
            width: 100,
            height: height,
            child: Center(
              child: Text(
                  function,
                style: TextStyle(
                    color: txtColor
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: SizedBox(
            width: 100,
            height: height,
            child: Center(
              child: Text(
                  component,
                style: TextStyle(
                    color: txtColor
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: SizedBox(
            width: 100,
            height: height,
            child: Center(
              child: Text(
                  assigned,
                style: TextStyle(
                    color: txtColor
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: SizedBox(
            width: 100,
            height: height,
            child: Center(
              child: Text(
                 dateCreated,
                style: TextStyle(
                    color: txtColor
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: SizedBox(
            width: 100,
            height: height,
            child: Center(
              child: Text(
                  dateDue,
                style: TextStyle(
                    color: txtColor
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return row;
  }

  void rowPressed(id, table){
    var workOrder;
    if (table == "today"){
      workOrder = workOrders["todayJobInfo"][id];
    }else if (table == "week"){
      workOrder = workOrders["weekJobInfo"][id];
    }else{
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WOScreen(workOrder))
    );

  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = Hive.box(constants.userBox);
    String username = userInfo.get(constants.usernameKey) ?? "";
    String password = userInfo.get(constants.passKey) ?? "";
    String server = userInfo.get(constants.serverKey) ?? "";
    getData = GetData(username: username,password: password,url: "http://${server}/getHomeData.php");
    getData.homeData().then((value) {
      workOrders = value;
      List<Widget> todays= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
      List<Widget> weeks= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
      for(int i = 0;i<value['todayJobInfo'].length;i++){
        var row = value['todayJobInfo'][i];
        TextButton button = TextButton(
            onPressed: () => rowPressed(i, "today"),
            child: rowBuilder("${row['yearID']}/${row['JobID']}", row['Job_Name'], "${row['hierachy']}-${row['functionID']}", "${row['ComponentShort']}-${row['ComponentNumber']}", row["Rank"], row["Date_Due"], row["Date_Created"])
        );
        todays.add(button);
      }

      for(int j = 0;j<value['weekJobInfo'].length;j++){
        var rowWeek = value['weekJobInfo'][j];
        TextButton button = TextButton(
            onPressed: () => rowPressed(j, "week"),
            child: rowBuilder("${rowWeek['yearID']}/${rowWeek['JobID']}", rowWeek['Job_Name'], "${rowWeek['hierachy']}-${rowWeek['functionID']}", "${rowWeek['ComponentShort']}-${rowWeek['ComponentNumber']}", rowWeek["Rank"], rowWeek["Date_Due"], rowWeek["Date_Created"])
        );
        weeks.add(button);
      }
      timesheetEntry = value['timesheetInfo'];
      setState(() {
        data = {"today":todays,"week":weeks};
        ckIN = value['ckStatus']?? "Clocked 1Out";
      });
    }).catchError((onError){
      Fluttertoast.showToast(
          msg: "login Unsuccseful",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16,
          textColor: Colors.black,
          backgroundColor: Colors.white
      );
    });
  }

  Future <void> refresh()async{
    String username = userInfo.get(constants.usernameKey) ?? "";
    String password = userInfo.get(constants.passKey) ?? "";
    String server = userInfo.get(constants.serverKey) ?? "";
    getData = GetData(username: username,password: password,url: "http://${server}/getHomeData.php");
    getData.homeData().then((value) {
      workOrders = value;
      List<Widget> todays= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
      List<Widget> weeks= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
      for(int i = 0;i<value['todayJobInfo'].length;i++){
        var row = value['todayJobInfo'][i];
        TextButton button = TextButton(
            onPressed: () => rowPressed(i, "today"),
            child: rowBuilder("${row['yearID']}/${row['JobID']}", row['Job_Name'], "${row['hierachy']}-${row['functionID']}", "${row['ComponentShort']}-${row['ComponentNumber']}", row["Rank"], row["Date_Due"], row["Date_Created"])
        );
        todays.add(button);
      }

      for(int j = 0;j<value['weekJobInfo'].length;j++){
        var rowWeek = value['weekJobInfo'][j];
        TextButton button = TextButton(
            onPressed: () => rowPressed(j, "week"),
            child: rowBuilder("${rowWeek['yearID']}/${rowWeek['JobID']}", rowWeek['Job_Name'], "${rowWeek['hierachy']}-${rowWeek['functionID']}", "${rowWeek['ComponentShort']}-${rowWeek['ComponentNumber']}", rowWeek["Rank"], rowWeek["Date_Due"], rowWeek["Date_Created"])
        );
        weeks.add(button);

      }
      timesheetEntry = value['timesheetInfo'];
      setState(() {
        data = {"today":todays,"week":weeks};
        ckIN = value['ckStatus']?? "Clocked Out";
      });
    }).catchError((onError){
      Fluttertoast.showToast(
          msg: "Refresh Unsuccessful",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16,
          textColor: Colors.black,
          backgroundColor: Colors.white
      );
    });
  }
  @override
  Widget build(BuildContext context) {
   return RefreshIndicator(
     onRefresh: refresh,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
          Expanded(
              flex: 2,
              child: TextButton(
                  onPressed: (){
                    String username = userInfo.get(constants.usernameKey) ?? "";
                    String password = userInfo.get(constants.passKey) ?? "";
                    String server = userInfo.get(constants.serverKey) ?? "";
                    if(ckIN=="Clocked In"){
                        GetData data = GetData(password: password, username: username, url: "http://${server}/clockOut.php");
                        data.clockOut(timesheetEntry).then((value){
                          if (value['ClockedStatus']){
                            setState(() {
                            ckIN = "Clocked Out";
                            });
                          }
                        }).onError((error, stackTrace) => null);
                    }else {
                      GetData data = GetData(username: username,
                          password: password,
                          url: "http://${server}/clockIn.php");
                      data.clockIn().then((value) {
                        if (value['ClockedStatus']) {
                          setState(() {
                            ckIN = "Clocked In";
                          });
                        }
                      }).onError((error, stackTrace) => null);
                    }
                  },
                  child: Text(
                      ckIN,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    ),
                  )
              )
          ),
          Expanded(
               flex: 8,
               child: Scaffold(
                 appBar: AppBar(
                   title: Text(
                       "Today's Jobs: ${jobNum(data['today']!.length)}",
                     style: TextStyle(
                       color: Colors.black,
                     ),
                   ),
                   backgroundColor: Colors.white,
                   toolbarHeight: 30.0,
                   elevation: 0.0,
                 ),
                 body: SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   physics: AlwaysScrollableScrollPhysics(),
                   child: SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Column(
                           children:data["today"] ??[]
                       ),
                   ),
                 ),
               )
           ),
         Expanded(flex: 1,child: Text(""),),
         Expanded(
             flex: 18,
             child: Scaffold(
               appBar: AppBar(
                 title: Text(
                   "This weeks Jobs: ${jobNum(data['week']!.length)}",
                   style: TextStyle(
                     color: Colors.black,
                   ),
                 ),
                 backgroundColor: Colors.white,
                 toolbarHeight: 30.0,
                 elevation: 0.0,
               ),
               body: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 physics: AlwaysScrollableScrollPhysics(),
                 child: SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Column(
                         children:data["week"] ??[]
                     ),
                 ),
               ),
             )
         )
       ],
     ),
   );

  }

  colorTXT(dateDue) {
    try {
      DateTime due = DateTime.parse(dateDue);
      if (due.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
        return Colors.red;
      } else {
        return Colors.black54;
      }
    }catch(exception){
      return Colors.black;
    }
  }

  jobNum(int length) {
    if(length == 0){
      return length;
    }else{
      return length - 1;
    }
  }
}
