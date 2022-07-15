import 'package:flutter/material.dart';

import '../../functionscreen/functionpage.dart';

class WorkOrderInfo extends StatelessWidget {
  var workOrder;
  WorkOrderInfo(this.workOrder,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Function: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            TextButton(
              onPressed:(){
                var function = {'heirachy':workOrder['hierachy'],"function":workOrder['functionID'],'functionName':""};
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FunctionPage(function))
                );
              },
              child: Text(
                  "${workOrder['hierachy']}-${workOrder['functionID']}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            "Job Name: ${workOrder['Job_Name']}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(
          child: Text(
            "Component: ${workOrder['ComponentShort']}-${workOrder['ComponentNumber']}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(
          child: Text(
            "Discipline: ${workOrder['Rank']}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(
          child: Text(
            "Date Due: ${workOrder['Date_Due']}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(
          child: Text(
            "Date Created: ${workOrder['Date_Created']}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(
          child: Text(
            "Date Complete: ${workOrder['Date_Complete']??""}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(
          child: Text(
            "Type: ${type(workOrder['routineDuty'])}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        Center(child: Text("Frequency: ${workOrder['frequency']??""}")),
        Center(child: Text("Status: ${status(workOrder['Complete'])}")),
        Center(child: Text("Complete By: ${workOrder['FirstName']??""} ${workOrder['LastName']??""}"))

      ],
    );
  }
  type(workOrder) {
    if (workOrder == "1"){
      return "Routine Maintenance";
    }else{
      return "Corrective";
    }
  }

  status(workOrder) {
    if (workOrder == "1"){
      return "Complete";
    }else{
      return "Not Started";
    }
  }
}
