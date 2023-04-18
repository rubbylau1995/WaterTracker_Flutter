
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
  _WaterConsumptionTrackerState createState() => _WaterConsumptionTrackerState();
}

class _WaterConsumptionTrackerState extends State<WaterConsumptionTracker> {
  double _waterConsumed = 0;

  void _incrementWaterConsumption() {
    setState(() {
      _waterConsumed += 0.25;
      _saveWaterConsumption();
    });
  }

  void _resetWaterConsumption() {
    setState(() {
      _waterConsumed = 0;
      _saveWaterConsumption();
    });
  }

  void _saveWaterConsumption() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('waterConsumed', _waterConsumed);
  }

  void _loadWaterConsumption() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _waterConsumed = prefs.getDouble('waterConsumed') ?? 0;
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
              'Cups of water consumed today:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
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
                  width: 300 * _waterConsumed / 2,
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
              '${_waterConsumed.toStringAsFixed(1)} cups',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementWaterConsumption,
                  child: Text('Add 0.25 cups'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetWaterConsumption,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => _showSnackbar('This app was created by Sage.'),
            ),
          ],
        ),
      ),
    );
  }
}