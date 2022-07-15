import 'package:flutter/cupertino.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/defects_body.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/function_hierachy_body.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/home_body.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/stock_body.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/timesheet_body.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/workorders_body.dart';

class MyProjectAppConstants{

  final String homestring = "Home";
  final Widget homebody = HomeBody();

  final String timesheetstring = "Time Sheet";
  final Widget timesheetbody = TimeSheetBody();

  final String workorderstring = "Work Orders";
  final Widget workorderbody = WorkOrderBody();

  final String stockstring = "Stock";
  final Widget stockbody = StockBody();

  final String defectsstring = "Defects";
  final Widget defectbody = DefectBody();

  final String functionstring = "Function Heirachy";
  final Widget functionbody = FunctionHeirachyBody();

  final String accountstring = "Crew Account";
  final Widget accountbody = StockBody();

  final String settingsstring = "Settings";
  final String filters = "Filters";
  final String sortby = "Sort By";

  final String userBox = "User Box";
  final String filteringBox = "filtering";

  // Keys for persistent Data
  final String usernameKey = "UserKey";
  final String passKey = "PassKey";
  final String serverKey = "Server";
  final String fNameKey = "fNameKey";
  final String lNameKey = "lNameKey";
  final String depKey = "DepartmentKey";
  final String rankKey = "rankKey";

  final String ascOrderkey = "ascOrderkey";
  final String sortbyKey = "sortKey";



}