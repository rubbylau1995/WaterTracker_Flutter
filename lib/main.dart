import 'package:flutter/material.dart';
import 'package:water/constant.dart';
import 'package:water/screen/WaterConsumption_Home/HomeScreen.dart';
import 'package:water/utils/material_color_helper.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
        theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        // primaryColor: Colors.black,
        primarySwatch: createMaterialColor(kPrimaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(color: createMaterialColor(kPrimaryColor)),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: HomeScreen(),
    );
  }
}


//In this version, the `_newWaterConsumed` variable is used to store the updated water consumption value, and the `Save` button calls the `_saveWaterConsumption` method to save the updated value to `SharedPreferences`. The `_incrementWaterConsumption` method updates only the `_newWaterConsumed` variable and does not save the value immediately. The `Add 0.25 cups` button and the `Reset` button also updates only the `_newWaterConsumed` variable.