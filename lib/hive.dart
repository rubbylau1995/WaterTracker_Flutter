
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox<double>('waterBox');
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
  int _numTaps = 0;
  double _waterConsumed = 0;

  late Box<double> waterBox; // will init later

  @override
  void initState() {
    super.initState();
    waterBox = Hive.box<double>('waterBox');
    _waterConsumed = waterBox.get('water',) ?? 0;
  }

  void _onTap() {
    setState(() {
      _numTaps++;
      _waterConsumed = _numTaps * 0.5;
    });
    waterBox.put('water', _waterConsumed);
  }

  void _reset() {
    setState(() {
      _numTaps = 0;
      _waterConsumed = 0;
    });
    waterBox.put('water', _waterConsumed);
  }

  void _submit() {
    print('Submit button pressed!');
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
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _onTap,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: _reset,
              child: Text('Reset'),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}