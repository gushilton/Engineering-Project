import 'package:flutter/material.dart';

import '../../../functionscreen/functionpage.dart';

class FunctionBuilder extends StatefulWidget {
  var function;
  FunctionBuilder(this.function,{Key? key}) : super(key: key);

  @override
  _FunctionBuilderState createState() => _FunctionBuilderState(function);
}

class _FunctionBuilderState extends State<FunctionBuilder> {

  var function;
  _FunctionBuilderState(this.function);

  @override
  Widget build(BuildContext context) {
    List<Widget> show = [
      Row(
        children: [
          SizedBox(width: 45,),
          TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FunctionPage(function))
                );
              },
              child: Text(
                "${function['heirachy']??""}-${function['function']??""}  ${function['functionName']??""}",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54
                ),
              )
          ),
        ],
      ),
    ];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: show
    );
  }
}