import 'package:flutter/material.dart';
import 'package:myproject/screens/pages/mainscreen/bodies/functionbody/menu2Builder.dart';

class Menu1Builder extends StatefulWidget {
  var div1;
  var div2;
  var div3;
  Menu1Builder(this.div1,this.div2,this.div3,{Key? key}) : super(key: key);

  @override
  _Menu1BuilderState createState() => _Menu1BuilderState(div1,div2,div3);
}

class _Menu1BuilderState extends State<Menu1Builder> {
  bool showChildren = false;
  var div1;
  var div2;
  var div3;


  _Menu1BuilderState(this.div1,this.div2,this.div3);

  @override
  Widget build(BuildContext context) {
    List<Widget> show = [
      TextButton(
        onPressed: (){
          setState(() {
            showChildren = !showChildren;
          });
        },
        child: Text(
            "${div1['Division1']??""}-${div1["DivisionName"]??""}",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black
          ),
        )
      ),
    ];
    if (showChildren){
      for(int i = 0; i<div2.length;i++){
        show.add(Menu2Builder(div2[i],div3[i]));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: show
    );
  }
}
