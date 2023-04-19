import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Import the Intl package for date formatting

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
  final List<int> _waterOptions = [1,2,3,4,5,6,7,8,9,];

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
    String key = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setDouble(key, _newWaterConsumed);

    setState(() {
      _waterConsumed = _newWaterConsumed + _waterConsumed;
      _newWaterConsumed = 0;
    });
    _showSnackbar('Water consumption saved.');
  }

  void _loadWaterConsumption() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _waterConsumed = prefs.getDouble('waterConsumed') ?? 0;
      _newWaterConsumed = _waterConsumed;
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
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text('Water Tracker'),
        //   ),
        // body: Center(
        Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Today consumed: ${_waterConsumed.toStringAsFixed(2)} cups',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Cups of water consumed today:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10), // 距離
          Stack(
            children: [
              Container(
                width: 300,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                width: 300 * _waterConsumed / _standardWaterIntake,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '${_newWaterConsumed.toStringAsFixed(2)} cups',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
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
            items: _waterOptions.map((int value) {
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
    //   ),
    // );
  }
}
