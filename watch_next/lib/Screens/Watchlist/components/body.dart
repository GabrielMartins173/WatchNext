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
              child: Card(child:
              Row(children: [
                Container(
                  child:
                      Image.asset('assets/images/' + item.name + '_logo.png'),
                  width: 100,
                ),
                Text(item.name),
                ElevatedButton(onPressed: () {}, child: const Text("delete"))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween),
                color: const Color(0xA41C1C1C),
                semanticContainer: true,
                shadowColor: const Color(0xD8F63434),
                elevation: 15,
            )))
        .toList();

    return Column(children: containerList);
  }
}
