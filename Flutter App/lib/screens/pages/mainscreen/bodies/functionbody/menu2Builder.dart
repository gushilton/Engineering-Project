import 'package:flutter/material.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/functionbody/functionBuilder.dart';

import 'menu3Builder.dart';

class Menu2Builder extends StatefulWidget {
  var div2;
  var div3;
  Menu2Builder(this.div2,this.div3,{Key? key}) : super(key: key);

  @override
  _Menu2BuilderState createState() => _Menu2BuilderState(div2,div3);
}

class _Menu2BuilderState extends State<Menu2Builder> {
  var showChildren = false;
  var div2;
  var div3;
  _Menu2BuilderState(this.div2, this.div3);


  @override
  Widget build(BuildContext context) {
    List<Widget> show = [
      Row(
        children: [
          SizedBox(width: 15,),
          TextButton(
              onPressed: (){
                setState(() {
                  showChildren = !showChildren;
                });
              },
              child: Text(
                  "${div2['Division1']??""}${div2['Division2']??""}-${div2["DivisionName"]??""}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black
                ),
              )
          ),
        ],
      ),
    ];
    if (showChildren){
      if (div3.length > 0) {
        for(int i =0; i<div3.length;i++){
          show.add(Menu3Builder(div3[i]));
        }
      }else{
        show.add(Menu3Builder(div2));
      }
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: show
    );
  }
}