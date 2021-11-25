import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Entities/review.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.title, required this.loggedUser})
      : super(key: key);

  // This Widgets is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App Widgets) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User loggedUser;

  @override
  State<Body> createState() => _Reviews();
}

class _Reviews extends State<Body> {
  List<Widget> reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
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
    List<Review> reviewList =
        await WatchNextDatabase.findReviewsByUser(widget.loggedUser.id);

    List<Item> itemList = [];

    for (Review review in reviewList) {
      itemList.add(await WatchNextDatabase.findItemById(review.itemId));
    }

    var reviews = reviewList
        .map((review) => Card(
              key: ValueKey(review),
              child: ExpansionTile(
                title: Row(children: [
                  SizedBox(
                    child: Image.asset('assets/images/' +
                        itemList
                            .firstWhere((item) => item.id == review.itemId)
                            .name +
                        '_logo.png'),
                    width: 100,
                  ),
                  Text(itemList
                      .firstWhere((item) => item.id == review.itemId)
                      .name)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround),
                children: [
                  Text(review.review),
                  ElevatedButton(
                      onPressed: () {
                        WatchNextDatabase.removeReview(
                            review.userId, review.itemId);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xC4DE0000)),
                      child: const Text("delete"))
                ],
              ),
              color: const Color(0xA41C1C1C),
              semanticContainer: true,
              shadowColor: const Color(0xD8F63434),
              elevation: 15,
            ))
        .toList();

    return ReorderableListView(
        children: reviews,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = reviews.removeAt(oldIndex);
            reviews.insert(newIndex, item);
          });
        });
  }
}
