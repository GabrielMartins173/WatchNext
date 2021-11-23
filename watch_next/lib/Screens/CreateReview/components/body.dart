import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Widgets/button_widget.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.title,
      required this.loggedUserId,
      required this.itemId})
      : super(key: key);

  final String title;
  final int loggedUserId;
  final int itemId;

  @override
  State<Body> createState() => _CreateReview();
}

class _CreateReview extends State<Body> {
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
                future: createFormReview(),
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

  Future<Widget> createFormReview() async {
    Item itemToReview = await WatchNextDatabase.findItemById(widget.itemId);

    String review = "";

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: itemToReview.name,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText:
                        'You are writing a review about the following show'),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Write your review here'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  review = value;
                },
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Publish Review',
                onClicked: () async {
                  WatchNextDatabase.addReview(
                      widget.loggedUserId, widget.itemId, review);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
