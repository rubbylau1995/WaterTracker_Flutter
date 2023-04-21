import 'package:flutter/material.dart';
import 'package:water/constant.dart';
import 'package:water/screen/Medicine/MedicineIntakeTracker.dart';
// import 'package:flutter_application_2/screens/details/components/body_detail.dart';

class MedicineScreen extends StatelessWidget { //stle
  const MedicineScreen({Key? key}) : super(key: key);
//testing git
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
     body: MedicineIntakeTracker(),
    );
  }
}
