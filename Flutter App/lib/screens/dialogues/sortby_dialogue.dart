import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myproject/classes/constants.dart';

class SortByDialogue extends StatefulWidget {
  const SortByDialogue({Key? key}) : super(key: key);

  @override
  _SortByDialogueState createState() => _SortByDialogueState();
}

class _SortByDialogueState extends State<SortByDialogue> {
  late Box filterBox;
  MyProjectAppConstants constants = MyProjectAppConstants();
  List<String> sortby = ["Work Order","Job Name","Function","Component","Discipline","Date Created","Date Due"];
  late bool asc;
  late String _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterBox = Hive.box(constants.filteringBox);
    _value = filterBox.get(constants.sortbyKey) ?? "Work Order";
    asc = filterBox.get(constants.ascOrderkey) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 500.0,
        child: Column(
          children: sortBy() ,
        ),
      ),
    );
  }

  List<Widget> sortBy(){
    List<Widget> tiles = [];
    for (int i =0; i<sortby.length;i++){
      tiles.add(
          RadioListTile(
              title: Text(sortby[i]),
              value: sortby[i],
              groupValue: _value,
              onChanged: (dynamic d){
                setState(() {
                  _value = d;
                });
              })
      );
    }
    tiles.add(IconButton(
        onPressed: (){
          setState(() {
            asc = !asc;
          });
        },
        icon: _icon(),
    ));
    tiles.add(TextButton(
      onPressed: (){
        Navigator.pop(context);
        filterBox.put(constants.ascOrderkey, asc);
        filterBox.put(constants.sortbyKey, _value);

      },
      child: Text("Confirm"),
    ));
    return tiles;
  }
  Icon _icon(){
    if (asc){
    return Icon(Icons.arrow_downward);}
    else{
      return Icon(Icons.arrow_upward);
    }
  }
}
