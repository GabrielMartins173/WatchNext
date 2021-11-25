import 'package:flutter/material.dart';
import 'package:watch_next/Entities/notification.dart';

class Body extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Body({required this.listNoti});

  final List<NotificationApp> listNoti;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listNoti.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(10),
                color: const Color(0xC4DE0000),
                child: Center(heightFactor: 2,
                  child: Text(listNoti[index].message),
                ),
              );
            })
      ],
    ));
  }
}
