import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSheetGrid extends StatelessWidget {
  var timesheets;
  var time24;
  TimeSheetGrid(this.timesheets,this.time24,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    var timesheet = timesheets;
    var weekHours = 0;
    var prev24Hours = 0;
    double width = 100.0;
    double quart = width/4;
    var colOut = Colors.white;
    var colIn = Colors.green;
    var colOvr = Colors.red;

    for(int i = 0;i<time24.length;i++){
      DateTime timeIn = DateTime.parse(timesheet[i]['TimeIn']);
      DateTime timeOut;
      if (timesheet[i]['TimeOut'] == null) {
        timeOut = DateTime.now();

      }else{
        timeOut = DateTime.parse(timesheet[i]['TimeOut']);
      }
      Duration difference24 = timeOut.difference(timeIn);
      prev24Hours += difference24.inMinutes;
    }


    var keys = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];

    List<Widget> r =[        SizedBox(
        width: 100,
        child: Text("Date")
    )];
    for (int i=0;i<keys.length;i++){
      r.add(SizedBox(
          width: width,
          child: Text(keys[i])));
    }


    List<Widget> rows = [Row(
      children: r,
    )];



    for (int i = 6;i>=0;i--) {
      bool Over = false;
      var hours = {"00":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"01":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"02":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"03":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"04":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"05":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"06":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"07":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"08":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"09":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"10":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"11":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"12":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"13":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"13":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"14":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"15":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"16":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"17":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"18":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"19":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"20":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"21":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"22":{"00":colOut,"15":colOut,"30":colOut,"45":colOut},"23":{"00":colOut,"15":colOut,"30":colOut,"45":colOut}};
      String day = DateTime.now().subtract(Duration(days: i)).toString().substring(0, 10);
      List<Widget> rowChildren = [SizedBox(
          width: 100,
          child: Text(day)
      )
      ];
      bool multiDay = false;

      for (int j = 0; j < timesheet.length; j++) {
        Duration dif;
        if (timesheet[j]["TimeIn"].toString().contains(day)) {
          DateTime timeIn = DateTime.parse(timesheet[j]['TimeIn']);
          DateTime timeOut;
          if (timesheet[j]['TimeOut'] == null) {
            timeOut = DateTime.now();

          }else{
              timeOut = DateTime.parse(timesheet[j]['TimeOut']);
          }

          if(!multiDay) {
            dif = timeOut.difference(timeIn);
            weekHours = weekHours + dif.inMinutes;
          }
          int days = timeOut.day - timeIn.day;
          if (days == 0){
            multiDay = false;
          }else{
            multiDay = true;
            timeIn.add(Duration(days: 1));
            timesheet.insert(j+1,{"TimeIn":"${timeIn.add(Duration(days: 1)).toString().substring(0,10)} 00:00","TimeOut":timeOut.toString().substring(0,19)});
            timeOut = DateTime.parse("${day} 23:45");
          }



          var inHourKey = timeIn.toString().substring(11, 13);
          var inMinuteKey;
          if ((53 < timeIn.minute && timeIn.minute < 60) || (0 <= timeIn.minute && timeIn.minute <= 7)) {
            inMinuteKey = "00";
          } else if (7 < timeIn.minute && timeIn.minute <= 23) {
            inMinuteKey = "15";
          } else if (23 < timeIn.minute && timeIn.minute <= 37) {
            inMinuteKey = "30";
          } else if (37 < timeIn.minute && timeIn.minute <= 53) {
            inMinuteKey = "45";
          }
          var outHourKey = timeOut.toString().substring(11, 13);
          var OutMinuteKey;
          if ((53 < timeOut.minute && timeOut.minute < 60) || (0 <= timeOut.minute && timeOut.minute <= 7)) {
            OutMinuteKey = "00";
          } else if (7 < timeOut.minute && timeOut.minute <= 23) {
            OutMinuteKey = "15";
          } else if (23 < timeOut.minute && timeOut.minute <= 37) {
            OutMinuteKey = "30";
          } else if (37 < timeOut.minute && timeOut.minute <= 53) {
            OutMinuteKey = "45";
          } else {
            OutMinuteKey = "00";
          }
          bool hourIn = false;

          var hourKeys = hours.keys;
          for (int a = 0; a < hourKeys.length; a++) {
            var hourKey = hourKeys.elementAt(a);
            var minKeys = hours[hourKey]!.keys;
            if (hourKey == inHourKey) {
              for (int b = 0; b < minKeys.length; b++) {
                var minKey = minKeys.elementAt(b);
                if (minKey == inMinuteKey) {
                  hourIn = true;
                }
              }
            }
            if (hourIn) {
              for (int b = 0; b < minKeys.length; b++) {
                var minKey = minKeys.elementAt(b);
                if (minKey == OutMinuteKey && hourKey == outHourKey) {
                  hourIn = false;
                  break;
                }
                if (weekHours > 5460 || (prev24Hours > 840 && timeOut.toString().contains(today.toString().substring(0,10)))){
                  hours[hourKey]![minKey] = colOvr;
                }else{
                  hours[hourKey]![minKey] = colIn;
                }
              }
            }
          }
        }
      }



      var boxRow = Row();
      var f = hours.length;
      for (int k = 0; k < keys.length; k++) {
        String key = keys[k];
        var x = 1;
        boxRow = Row(
          children: [
            Container(
              height: 20,
              width: quart,
              child: ColoredBox(
                color: hours[key]!["00"] ?? Colors.black,
              ),

            ),
            Container(
              height: 20,
              width: quart,
              child: ColoredBox(
                color: hours[key]!["15"] ?? Colors.black,
              ),

            ),
            Container(
              height: 20,
              width: quart,
              child: ColoredBox(
                color: hours[key]!["30"] ?? Colors.black,
              ),

            ),
            Container(
              height: 20,
              width: quart,
              child: ColoredBox(
                color: hours[key]!["45"] ?? Colors.black,
              ),

            ),
          ],
        );
        SizedBox box = SizedBox(
          width: width,
          child: boxRow,
        );
        rowChildren.add(box);
      }
      var x = 2;
      Row row = Row(
          children: rowChildren
      );
      rows.add(Divider(
        height: 10,
        color: Colors.black54,
      ));
      rows.add(row);

    }


    return Column(
      children: rows,
    );
  }
}

