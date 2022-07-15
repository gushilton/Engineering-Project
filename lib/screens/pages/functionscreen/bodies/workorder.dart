import 'package:flutter/material.dart';

import '../../workorderscreen/wo_screen.dart';

class FunctionWorkOrders extends StatefulWidget {
  var function;
  FunctionWorkOrders(this.function,{Key? key}) : super(key: key);

  @override
  _FunctionWorkOrdersState createState() => _FunctionWorkOrdersState(function);
}

class _FunctionWorkOrdersState extends State<FunctionWorkOrders> {
  var function;

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
    var workOrder = function["workOrders"][id];
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WOScreen(workOrder))
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

  _FunctionWorkOrdersState(this.function);
  @override
  Widget build(BuildContext context) {
    List<Widget> workorder= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created")];
    try{
     var workOrder = function['workOrders'];


    for(int i = 0;i<workOrder.length;i++) {
      var row = workOrder[i];
      TextButton button = TextButton(
          onPressed: () => rowPressed(i),
          child: rowBuilder(
              "${row['yearID']}/${row['JobID']}",
              row['Job_Name'],
              "${row['hierachy']}-${row['functionID']}",
              "${row['ComponentShort']}-${row['ComponentNumber']}",
              row['Rank'],
              row["Date_Due"],
              row["Date_Created"])
      );

      workorder.add(button);

    }
    }catch(e){

      var x= 1;
    }

    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: workorder,
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async{

  }
}
