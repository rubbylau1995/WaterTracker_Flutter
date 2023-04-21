import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:water/constant.dart'; // Import the Intl package for date formatting

class WaterConsumptionTracker extends StatefulWidget {
  @override
  _WaterConsumptionTrackerState createState() =>
      _WaterConsumptionTrackerState();
}

class _WaterConsumptionTrackerState extends State<WaterConsumptionTracker> {
  double _waterConsumed = 0; // get from shared_pre and will save to shared_pre
  double _newWaterConsumed = 0; // updated by user
  double _maxInputWaterConsumed = 8;
  double _waterIncreaseSize = 0.5;
  double _standardWaterIntake = 8;
  int _targetWaterConsumed = 8;
  double _percentOfTargetAchived = 0;
  String _waterUnit = "C";

  String key = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final List<String> _waterUnitOpt = ['cups', 'ml', 'L'];
  final List<int> _waterOpt = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];

  void _incrementWaterConsumption() {
    setState(() {
      _newWaterConsumed += _waterIncreaseSize;
    });
    // _showSnackbar('Water consumption saved.');
  }

  void _resetWaterConsumption() {
    setState(() {
      // _waterConsumed = 0;
      _newWaterConsumed = 0;
    });
    // _showSnackbar('Water consumption saved.');
  }

  void _saveWaterConsumption() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setDouble(key, _newWaterConsumed + _waterConsumed);
   
    setState(() {
      _waterConsumed = _newWaterConsumed + _waterConsumed;
      _newWaterConsumed = 0;
      _percentOfTargetAchived = _waterConsumed / _targetWaterConsumed > 1.0 ? 1.0 : _waterConsumed / _targetWaterConsumed;
    });
   
    _showSnackbar('Water consumption saved.');
  }

  void _loadWaterConsumption() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _waterConsumed = prefs.getDouble(key) ?? 0;
      // _newWaterConsumed = _waterConsumed;
      _percentOfTargetAchived = _waterConsumed / _targetWaterConsumed > 1.0 ? 1.0 : _waterConsumed / _targetWaterConsumed;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadWaterConsumption();
  }

  @override
  Widget build(BuildContext context) {
    return
        SingleChildScrollView(
      child: Column(children: <Widget>[
          WaterConsumption(),
      ]),
    );
  }

  Container WaterConsumption() {
    return Container(
       margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding * 2,
        bottom: kDefaultPadding * 2.5,
      ),
      //       // padding: EdgeInsets.only(

      //       //     top: kDefaultPadding * 2,
      //       //    ),
      // child: Column(
      //   // mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
       
      //     SizedBox(height: 10),
      //     Text(
      //       'Cups of water consumed today:',
      //       style: TextStyle(fontSize: 20),
      //     ),
      //     SizedBox(height: 15), // 距離
      //     CircularPercentIndicator(
      //       radius: 100.0,
      //       lineWidth: 10.0,
      //       percent: _waterConsumed / _targetWaterConsumed ,
      //       center: Text('${(_waterConsumed / _targetWaterConsumed * 100).toStringAsFixed(1)}'),
      //       progressColor: kPrimaryColor,
      //     ),



  alignment: Alignment.center,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'Cups of water consumed today:',
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(height: 30),
      GestureDetector(
         onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Target Water Consumption',
          style: Theme.of(context).textTheme.bodyMedium,),
          content: TextField( // why onChanged
            keyboardType: TextInputType.number,
            onChanged: (value) {
              //  setState(() {
              //         _targetWaterConsumed = double.parse(newValue?.toString() ?? '0'),
              //       });
              setState(() {
            _targetWaterConsumed = int.parse(value);
            });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                // Save the target water consumption here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  },
        child: Center(
          child: CircularPercentIndicator(
            radius: 200.0,
            backgroundWidth: 25,
            lineWidth: 15.0,
            percent: _percentOfTargetAchived ,
            center: Text('$_waterConsumed cups' ,style: TextStyle(fontSize: 18)),         
            progressColor: kPrimaryColor,
          ),
        ),
      ),
          // Stack( // progress bar
          //   children: [
          //     Container(
          //       width: 300,
          //       height: 30,
          //       decoration: BoxDecoration(
          //         color: Colors.grey[300],
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //     ),
          //     Container(
          //       width: 300 * _waterConsumed / _standardWaterIntake,
          //       height: 30,
          //       decoration: BoxDecoration(
          //         color: Colors.blue,
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 50),
          Text(
            '${_newWaterConsumed.toStringAsFixed(1)} cups',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: _incrementWaterConsumption,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // half of the width (100) or height (100) of the button
              ),
              padding: EdgeInsets.all(
                  20), // adjust the padding to make the button bigger or smaller
              elevation: 5,
            ),
          ),
          SizedBox(height: 20),
          //  Slider(
          //   value: _newWaterConsumed,
          //   min: 0,
          //   max: _maxInputWaterConsumed,
          //   divisions: _maxInputWaterConsumed.toInt(),
          //   label: '${_newWaterConsumed.toStringAsFixed(2)} cups',
          //   onChanged: (double value) {
          //     setState(() {
          //       _newWaterConsumed = value;
          //     });
          //   },
          // ),

          DropdownButton<int>(
            value: null,
            hint: Text('Select amount of water drank'),
            onChanged: (int? newValue) {
              setState(() {
                _newWaterConsumed = newValue?.toDouble() ?? 0;
              });
            },
            items: _waterOpt.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _resetWaterConsumption,
                child: Text('Reset'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _saveWaterConsumption,
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
