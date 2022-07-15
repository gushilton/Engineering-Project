import 'package:flutter/material.dart';

class MethodBody extends StatelessWidget {
  var workOrder;
  MethodBody(this.workOrder,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(workOrder['details']),
    );
  }
}

