import 'package:dietationapp/src/dashboardsection/screens/homeScreen.dart';
import 'package:dietationapp/src/profileSection/screens/myProfileScreen.dart';
import 'package:flutter/material.dart';

import '../../apppointmentsSection/screens/upcomingAppointments.dart';
import '../../chatSection/screens/chatListScreen.dart';
import '../../chatSection/screens/recent_chat_list.dart';
import '../../profileSection/screens/myAccountScreen.dart';
import '../../resourcesSection/healthTipsSection/screens/resourcesOpenScreen.dart';

class BottomNavProvider extends ChangeNotifier {
  Widget currentScreen = const HomeScreen();
  int currentIndex = 0;

  updateCurrentScreen(int index) {
    switch (index) {
      case 0:
        currentIndex = index;
        currentScreen = const HomeScreen();
        notifyListeners();
        break;
      case 1:
        currentIndex = index;
        currentScreen = const UpcomingAppointmenrsScreen();
        notifyListeners();
        break;
      case 2:
        currentIndex = index;
        currentScreen = const ResourcesOpenScreen();
        notifyListeners();
        break;
      case 3:
        currentIndex = index;
        currentScreen = const RecentChatList();
        notifyListeners();
        break;
      case 4:
        currentIndex = index;
        currentScreen = const MyAccountScreen();
        notifyListeners();
        break;
    }
  }
}
