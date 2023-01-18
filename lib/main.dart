import 'package:provider/provider.dart';
import 'package:restaurant_api/api/api_service.dart';
import 'package:restaurant_api/common/navigation.dart';
import 'package:restaurant_api/data/database_helper.dart';
import 'package:restaurant_api/page/home_page.dart';
import 'package:restaurant_api/page/setting_page.dart';
import 'package:restaurant_api/providers/list_provider.dart';
import 'package:restaurant_api/providers/scheduling_provider.dart';
import 'providers/database_provider.dart';
import 'package:restaurant_api/page/search_page.dart';
import 'package:restaurant_api/page/search_page_result.dart';
import 'page/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_api/page/bookmark_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/utils/background_service.dart';
import '/utils/notification_helper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();
  
  await AndroidAlarmManager.initialize();
  
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(create: (_)=>ListRestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_)=>SchedulingProvider())      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        initialRoute: HomePage.routeName,
        navigatorKey: navigatorKey,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
        
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
          RestaurantSearchPageResult.routeName: (context) =>
              RestaurantSearchPageResult(
                query: ModalRoute.of(context)?.settings.arguments as String,
              ),
          BookmarksPage.routeName: (context) => const BookmarksPage(),
          SettingPage.routeName:((context) => const SettingPage())
        },
      ),
    );
  }
}
