import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WaterConsumptionTracker(),
    );
  }
}

class WaterConsumptionTracker extends StatefulWidget {
  @override
  _WaterConsumptionTrackerState createState() =>
      _WaterConsumptionTrackerState();
}

class _WaterConsumptionTrackerState extends State<WaterConsumptionTracker> {
  double _waterConsumed = 0; // get from shared_pre and will save to shared_pre
  double _newWaterConsumed = 0; // updated by user

  void _incrementWaterConsumption() {
    setState(() {
      _newWaterConsumed += 0.25;
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
    await prefs.setDouble('waterConsumed', _newWaterConsumed);
    setState(() {
      _waterConsumed = _newWaterConsumed + _waterConsumed;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already consumed: ${_waterConsumed.toStringAsFixed(2)} cups',
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
                  width: 300 * _newWaterConsumed / 2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementWaterConsumption,
                  child: Text('Add 0.5 cups'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetWaterConsumption,
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveWaterConsumption,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

//In this version, the `_newWaterConsumed` variable is used to store the updated water consumption value, and the `Save` button calls the `_saveWaterConsumption` method to save the updated value to `SharedPreferences`. The `_incrementWaterConsumption` method updates only the `_newWaterConsumed` variable and does not save the value immediately. The `Add 0.25 cups` button and the `Reset` button also updates only the `_newWaterConsumed` variable.