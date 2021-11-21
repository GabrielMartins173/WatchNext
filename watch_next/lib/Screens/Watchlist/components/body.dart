import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/database.dart';

class Body extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Body({required this.loggedUser});

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        FutureBuilder<Widget>(
            future: getCards(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("waiting");
              }
            }),
      ],
    ));
  }

  Future<Widget> getCards() async {
    List<Item> itemList =
        await WatchNextDatabase.findItemsByUser(loggedUser.id);

    var containerList = itemList
        .map((item) => Container(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Container(
                  child:
                      Image.asset('assets/images/' + item.name + '_logo.png'),
                  width: 100,
                ),
                Text(item.name),
                ElevatedButton(onPressed: () {}, child: const Text("delete"))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween),
              color: Colors.teal[600],
            ))
        .toList();

    return Column(children: containerList);
  }
}
