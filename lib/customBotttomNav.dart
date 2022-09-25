import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/profile/mainProfileScreen.dart';
import 'package:fitness_app_flutter/statics/staticsMainScreen.dart';
import 'package:fitness_app_flutter/timerScreens/timerMainScreen.dart';
import 'package:flutter/material.dart';
import 'homeScreens/dashBoardScreen.dart';
import 'insightsScreens/insightsDashBoard.dart';

class CustomBottomNavigationBar extends StatefulWidget {
   var dat;
    CustomBottomNavigationBar({Key? key,this.dat}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
    
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedScreenIndex = 0;

final   List _screens = [
   const   DashBoardScreen(),
    const TimerMainScreen(),
    const InsightsDashBoard(),
    const StaticsMainScreen(),
    const MainProfileScreen()
  ];
  
  
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
          selectedItemColor: themeColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: blackcolor.withOpacity(0.3),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
            BottomNavigationBarItem(
                icon: Icon(Icons.insights), label: 'Insights'),
            BottomNavigationBarItem(
                icon: Icon(Icons.signal_cellular_4_bar_outlined),
                label: "Statistics"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        ),
      ),
    );
  }
}
