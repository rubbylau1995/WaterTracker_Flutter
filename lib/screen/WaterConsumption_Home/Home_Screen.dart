import 'package:flutter/material.dart';
// import 'package:water/components/bottom_nav_bar.dart';
import 'package:water/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:water/screen/Medicine/Medicine_Screen.dart';
import 'package:water/screen/WaterConsumption_Home/WaterConsumptionTracker.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context), //route

      body: WaterConsumptionTracker(),
      //  bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
         elevation: 0, // layer , if adjust to 100, just like having a grey layer on top of the screen.
        leading: IconButton(
          // icon: SvgPicture.asset(iconPath + "/menu.svg", height: 24,width: 30, color: Colors.white,     ),
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MedicineScreen()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
        ]);
  }
}
