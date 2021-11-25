import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/CreateReview/create_review_screen.dart';
import 'package:watch_next/database.dart';
/*import 'package:watch_next/Screens/Notifications/notification_screen.dart';
import 'package:watch_next/Screens/Notifications/notification_service.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/database.dart';*/

class Body extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Body(
      {Key? key,
      required this.title,
      required this.item,
      required this.loggedUser});

  // This Widgets is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App Widgets) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Item item;
  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            ElevatedButton(
                onPressed: () {
                  WatchNextDatabase.addUserItem(loggedUser.id, item.id);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xC4DE0000)),
                child: const Text("Add to Watchlist")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateReviewScreen(loggedUserId : loggedUser.id, itemId: item.id)),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xC4DE0000)),
                child: const Text("Write a review")),
            Container(
              child: Image(
                  image:
                      AssetImage('assets/images/' + item.name + '_poster.jpg')),
              margin: const EdgeInsets.all(20),
              height: 300,
            ),
            Text(item.name, textScaleFactor: 3),
            Container(
              child: Column(
                children: [
                  const Text("Synopsis:",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans Serif')),
                  Text(item.description)
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF490101),
                  Color(0xFFA10214),
                ],
              )),
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
            )
          ]),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.red,
            ],
          )),
        ),
      ),
    );
  }
}
