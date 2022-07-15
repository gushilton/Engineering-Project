import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/api_request.dart';
import 'package:myproject/classes/constants.dart';

class DefectBody extends StatefulWidget {
  const DefectBody({Key? key}) : super(key: key);

  @override
  _DefectBodyState createState() => _DefectBodyState();
}

class _DefectBodyState extends State<DefectBody> {
  MyProjectAppConstants constants = MyProjectAppConstants();
  late Box userBox;
  late String username;
  late String password;
  late String server;

  var defect = [];
  List<Widget> defectList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box(constants.userBox);
    username = userBox.get(constants.usernameKey);
    password = userBox.get(constants.passKey);
    server = userBox.get(constants.serverKey);
    loadData("%");

  }

  loadData(dep){
    GetData getData = GetData(password: password, username: username, url: "http://${server}/getDefects.php");
    getData.getDefects(dep).then((value){

      defect = value['defects'];
      List<Widget> defects = [rowBuilder("Defect ID","Problem","Type","Location")];
      for(int i = 0;i<defect.length;i++){
        TextButton btr = TextButton(
          onPressed: (){},
          child: rowBuilder("${defect[i]['yearID']??""}/${defect[i]['JobID']??""}", defect[i]['problem']??"", defect[i]['department']??"", defect[i]['location']??""),
        );
        defects.add(btr);
      }
      setState(() {
        defectList = defects;
      });


    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: (){
                    loadData("%");
                  },
                  child: Text(
                    "All",
                    style: TextStyle(),
                  )
              ),
            ),
            Expanded(
              child:TextButton(
                onPressed: (){
                  loadData("Electrical");
                },
                child: Text(
                  "Electrical",
                  style: TextStyle(),
                )
            ),
            ),
            Expanded(
                child: TextButton(
                    onPressed: (){
                      loadData("Ventilation");
                    },
                    child: Text(
                      "Ventilation",
                      style: TextStyle(),
                    )
                )
            ),
            Expanded(
              child: TextButton(
                  onPressed: (){
                    loadData("Plumbing");
                  },
                  child: Text(
                    "Plumbing",
                    style: TextStyle(),
                  )
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: defectList,
          ),
        ),
      ),
    );
  }

  Widget rowBuilder(defectID,name,type,location) {
    Color txtColor = Colors.black;
    var height = 35.0;
    return Row(
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
                defectID,
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
                name,
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
                type,
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
                location,
                style: TextStyle(
                    color: txtColor
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
}
