import 'package:flutter/material.dart';

import '../../workorderscreen/wo_screen.dart';

class FunctionHistory extends StatefulWidget {
  var function;
  FunctionHistory(this.function,{Key? key}) : super(key: key);

  @override
  _FunctionHistoryState createState() => _FunctionHistoryState(function);
}

class _FunctionHistoryState extends State<FunctionHistory> {
  var function;

  _FunctionHistoryState(this.function);

  Widget rowBuilder(workOrder,jobName,function,component,assigned,dateDue,dateCreated,dateComplete){
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
                dateComplete,
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
    var workOrder = function["history"][id];
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WOScreen(workOrder))
    );

  }

  colorTXT(dateDue) {
    return Colors.black;
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

  @override
  Widget build(BuildContext context) {
    List<Widget> workorder= [rowBuilder("Work Order", "Job Name", "Function", "Component", "Discipline", "Date Due", "Date Created","Date Complete")];
    try{
      var workOrder = function['history'];


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
                row["Date_Created"],
                row['Date_Complete'])
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
