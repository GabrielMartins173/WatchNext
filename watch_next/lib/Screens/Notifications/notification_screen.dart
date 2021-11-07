import 'package:flutter/material.dart';
import 'package:watch_next/Screens/Notifications/components/body.dart';
import 'package:watch_next/notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.listNot}) : super(key: key);

  final List<NotificationApp> listNot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        listNoti: listNot,
      ),
    );
  }
}
