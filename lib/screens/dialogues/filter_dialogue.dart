import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';

class FilterDialogue extends StatefulWidget {
  const FilterDialogue({Key? key}) : super(key: key);

  @override
  _FilterDialogueState createState() => _FilterDialogueState();
}

class _FilterDialogueState extends State<FilterDialogue> {
  MyProjectAppConstants constants = MyProjectAppConstants();
  bool disciplinShowChildren = false;
  late String username;
  late String password;
  late String server;
  late Box userInfo;
  late Box filterInfo;
  late bool ischecked;
  var roleList = [];
  var roleMap = {};
  var test = "Date Due";

  roleMapChecked(){
    for (int i = 0; i<roleList.length;i++){
      roleMap.addAll({roleList[i]:false});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterInfo = Hive.box(constants.filteringBox);
    roleList = filterInfo.get("roles")??[];
    roleMapChecked();
    var x =1 ;

  }
  @override
  Widget build(BuildContext context) {
    ischecked = false;
    return Dialog(
      child: Container(
            height: 500.0,
            color: Colors.black12,
            child: Column(
                children: [
                  TextButton(
                    onPressed: ()async{
                      DateTime? dueDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.parse("2000-01-01"),
                          lastDate: DateTime.now().add(Duration(days: 5*365)),
                          initialDate: DateTime.now().add(Duration(days: 30)),

                      );
                      if(dueDate != null){
                      }
                    },
                    child: Text(
                        test,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),

                      ),
                  ),
                  Column(
                    children: disciplineShow()
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          "Confirm",
                        style: TextStyle(),
                      )
                  )
                ])

      ),
    );
  }
  var _value;
  disciplineDialog(){
    setState(() {
      disciplinShowChildren = !disciplinShowChildren;
    });
  }

  disciplineShow(){
    List<Widget> roles = [
      TextButton(
          onPressed: () => disciplineDialog(),
          child: Text(
            "Discipline Required",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0
            ),
          )
      )];
    List<Widget> role=[];
    if (disciplinShowChildren) {
      int x = roleList.length;
      for(int i = 0; i<roleList.length;i++){
        var key = roleList[i];
        Row row = Row(
            children:[Checkbox(
                tristate: false,
                value: roleMap[key],
                onChanged: (a){
                  var x = a;
                  setState(() {
                    roleMap[key] = a;
                  });
                }),
              Text(key['Rank']??"")
            ]);

        role.add(row);
      }
      Widget con = Container(
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: role,
          ),
        ),
      );
      roles.add(con);
    }

    return roles;
  }
}
