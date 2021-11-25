import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Followers/followers_screen.dart';
import 'package:watch_next/Screens/Following/following_screen.dart';
import 'package:watch_next/Screens/Home/home_screen.dart';
import 'package:watch_next/Screens/Reviews/reviews_screen.dart';
import 'package:watch_next/database.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, buildFuture(buildFutureText(WatchNextDatabase.countFollowers(loggedUser.id))), 'Followers', FollowersScreen(loggedUser: loggedUser)),
          buildDivider(),
          buildButton(context, buildFuture(buildFutureText(WatchNextDatabase.countFollowing(loggedUser.id))), 'Following', FollowingScreen(loggedUser: loggedUser)),
          buildDivider(),
          buildButton(context, buildFuture(buildFutureText(WatchNextDatabase.countReviewsByUser(loggedUser.id))), 'Reviews Published', ReviewsScreen(loggedUser: loggedUser)),
        ],
      );

  Future<Widget> buildFutureText(Future<String> future) async {
    return Text(await future, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
  }

  Widget buildFuture(Future<Widget> widget) {
    return FutureBuilder<Widget>(
        future: widget,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Text("waiting");
          }
        });
  }

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, Widget value, String text,
          [Widget? nextScreen]) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {
          if (nextScreen != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => nextScreen));
          }
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            value,
            const SizedBox(height: 2, width: 10),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
