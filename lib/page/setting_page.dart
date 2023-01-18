import '/providers/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/utils/notification_helper.dart';
import 'package:restaurant_api/page/detail_page.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';

  const SettingPage({Key? key}) : super(key: key);
  @override
  State<SettingPage> createState() => _SettingPagePageState();
}

class _SettingPagePageState extends State<SettingPage> {
  static const String settingsTitle = 'Settings';  

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
              title: const Text('Scheduling News'),
              trailing:Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
                        scheduled.scheduledNotif(value);
                      },
                    );
                  },
                ),
              ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SchedulingProvider>(context,listen: false).loadValue();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }
 
}
