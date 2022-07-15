import 'package:flutter/material.dart';


class FunctionInfo extends StatelessWidget {
  var function;
  var functionInfo;
  final Function() goto;
  FunctionInfo(this.function,this.functionInfo,{required this.goto, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Center(child: Text(function['functionName'])),
        Row(
          children: [
            Text("Installed Component:"),
            TextButton(
                onPressed: (){},
                child: Text("${functionInfo['component']?['ComponentShort']??""}-${functionInfo['component']?['ComponentNumber']??""}")
            )
          ],
        ),
        Row(
          children: [
            Text("Installed Component Serial Number:"),
            TextButton(
                onPressed: (){},
                child: Text("${functionInfo['component']?['SerialNumber']??""}")
            )
          ],
        ),
        Row(
          children: [
            Text("Installed Component Make:"),
            TextButton(
                onPressed: (){},
                child: Text("${functionInfo['component']?['Maker']??""}")
            )
          ],
        ),
        Row(
          children: [
            Text("Installed Component Model:"),
            TextButton(
                onPressed: (){},
                child: Text("${functionInfo['component']?['Model']??""}")
            )
          ],
        ),


        Row(
          children: [
            Text("Open Work Orders:"),
            TextButton(
                onPressed: goto,

                child: Text("${functionInfo['workOrders']?.length}")
            )
          ],
        ),
      ],
    );
  }
}
