import '/api/api_service.dart';
import '/providers/list_provider.dart';
import '/providers/scheduling_provider.dart';
import '/page/detail_page.dart';
import '/page/list_page.dart';
import '/page/setting_page.dart';
import '/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0; 
  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const SettingPage()
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label:"Home"
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Setting"      
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueGrey,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  } 

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }
}