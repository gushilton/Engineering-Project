import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/dialogues/filter_dialogue.dart';
import 'package:myproject/screens/dialogues/sortby_dialogue.dart';
import 'package:myproject/screens/dialogues/updateDialogue.dart';
import 'package:myproject/screens/pages/workorderscreen/wo_screen.dart';

class WorkOrderBody extends StatefulWidget {
  const WorkOrderBody({Key? key}) : super(key: key);

  @override
  _WorkOrderBodyState createState() => _WorkOrderBodyState();
}

class _WorkOrderBodyState extends State<WorkOrderBody> {

  MyProjectAppConstants constants = MyProjectAppConstants();
  late Box userBox;
  var workOrders;
  List<Widget> WOrders =[];

  bool ischecked = false;

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

  void rowPressed(id){
    var workOrder = workOrders["workOrders"][id];
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WOScreen(workOrder))
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box(constants.userBox);
    String username = userBox.get(constants.usernameKey);
    String password = userBox.get(constants.passKey);
    String server = userBox.get(constants.serverKey);
    GetData getData = GetData(password: password, username: username, url: "http://${server}/getWorkOrders.php");
    getData.getWorkOrders().then((value){
      workOrders = value;
      List<Widget> workorder= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
      for(int i = 0;i<value['workOrders'].length;i++){
        var row = value['workOrders'][i];
        TextButton button = TextButton(
            onPressed: () => rowPressed(i),
            onLongPress: () =>longPress(i),
            child: rowBuilder("${row['yearID']}/${row['JobID']}", row['Job_Name'], "${row['hierachy']}-${row['functionID']}", "${row['ComponentShort']}-${row['ComponentNumber']}", row['Rank'], row["Date_Due"], row["Date_Created"])
        );
        workorder.add(button);
      }
      setState(() {
        WOrders = workorder;
      });

    }).onError((error, stackTrace) => null);

  }


  Future<void> refresh() async{
    String username = userBox.get(constants.usernameKey);
    String password = userBox.get(constants.passKey);
    String server = userBox.get(constants.serverKey);
    GetData getData = GetData(password: password, username: username, url: "http://${server}/getWorkOrders.php");
    getData.getWorkOrders().then((value){
      workOrders = value;
      List<Widget> workorder= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
      for(int i = 0;i<value['workOrders'].length;i++){
        var row = value['workOrders'][i];
        TextButton button = TextButton(
            onPressed: () => rowPressed(i),
            onLongPress: () =>longPress(i),
            child: rowBuilder("${row['yearID']}/${row['JobID']}", row['Job_Name'], "${row['hierachy']}-${row['functionID']}", "${row['ComponentShort']}-${row['ComponentNumber']}", row['Rank'], row["Date_Due"], row["Date_Created"])
        );
        workorder.add(button);
      }
      setState(() {
        WOrders = workorder;
      });

    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 30.0,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: (){
              showDialog(context: context,
                  builder: (BuildContext context){
                    return FilterDialogue();
                  }
              );
            }, child: Text("Filter")),
            TextButton(
                onPressed: (){
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return SortByDialogue();
                      }
                  );
                },
                child: Text("Sort By"))
          ],
        ),
      ),*/
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: WOrders,
            ),
          ),
        ),
      ),
    );
  }

  colorTXT(dateDue) {
    try {
      DateTime due = DateTime.parse(dateDue);
      if (due.isBefore(DateTime.now())) {
        return Colors.red;
      } else {
        return Colors.black54;
      }
    }catch(exception){
      return Colors.black;
    }
  }

  longPress(int i) {
    var workOrder = workOrders["workOrders"][i];

    showDialog(
        context: context,
        builder: (BuildContext context){
          return UpdateDialogue(workOrder,refresh);
        });
}
}
