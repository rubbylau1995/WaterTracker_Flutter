import 'package:flutter/material.dart';
// import 'package:water/components/bottom_nav_bar.dart';
import 'package:water/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:water/screen/WaterConsumption_Home/WaterConsumptionTracker.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
       appBar: buildAppBar(), //route
    
       body: WaterConsumptionTracker(),
      //  bottomNavigationBar: BottomNavBar(),
       
       
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 100,
      leading: IconButton(
        // icon: SvgPicture.asset(iconPath + "/menu.svg", height: 24,width: 30, color: Colors.white,     ),   
         icon: const Icon(Icons.menu_rounded),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
        ),
      ]
    );
  }
}
