import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Widgets/button_widget.dart';
import 'package:watch_next/Widgets/numbers_widget.dart';
import 'package:watch_next/Widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: 'watch_next/assets/images/stingy.jpg',
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(widget.loggedUser),
          const SizedBox(height: 24),
          const NumbersWidget(),
          const SizedBox(height: 36),
          Center(child: buildPrivacyButton()),
          const SizedBox(height: 12),
          Center(child: buildReviewsButton()),
          const SizedBox(height: 12),
          Center(child: buildInfoButton()),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildPrivacyButton() => ButtonWidget(
    text: 'Account Information',
    onClicked: () {},
  );

  Widget buildReviewsButton() => ButtonWidget(
    text: '        My Reviews        ',
    onClicked: () {},
  );

  Widget buildInfoButton() => ButtonWidget(
    text: '     Privacy Policy     ',
    onClicked: () {},
  );
}