import 'package:flutter/material.dart';
import 'package:watch_next/Screens/Followers/followers_screen.dart';
import 'package:watch_next/Screens/Following/following_screen.dart';
import 'package:watch_next/Screens/Home/home_screen.dart';
import 'package:watch_next/Screens/Reviews/reviews_screen.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '5', 'Followers', FollowersScreen()),
          buildDivider(),
          buildButton(context, '6', 'Following', FollowingScreen()),
          buildDivider(),
          buildButton(context, '50', 'Reviews Published'),
        ],
      );
  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text,
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
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2, width: 10),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
