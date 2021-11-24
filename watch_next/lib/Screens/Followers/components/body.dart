import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Widget>(
            future: getFollowers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("waiting");
              }
            }));
  }
}

Future<Widget> getFollowers() async {
  List<User> users = await WatchNextDatabase.findFollowers(5);
  return Scaffold(
    body: PageView(children: [
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(users[index].imagePath),
                  ),
                  title: Center(
                    child: Text(users[index].name),
                  ),
                ),
              ),
            );
          })
    ]),
  );
}
