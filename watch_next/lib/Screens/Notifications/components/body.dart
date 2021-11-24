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
              return Container(
                height: 50,
                color: const Color.fromRGBO(15, 27, 43, 0),
                child: Center(
                  child: Text(listNoti[index].message),
                ),
              );
            })
      ],
    ));
  }
}
