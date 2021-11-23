import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/PrivacyPolicy/privacy_policy_screen.dart';
import 'package:watch_next/Screens/Profile/edit_profile.dart';
import 'package:watch_next/Screens/Reviews/reviews_screen.dart';
import 'package:watch_next/Widgets/button_widget.dart';
import 'package:watch_next/Widgets/numbers_widget.dart';
import 'package:watch_next/database.dart';

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
        body: FutureBuilder<Widget>(
            future: buildBody(),
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

  Future<Widget> buildBody() async {
    User user = await WatchNextDatabase.findUserById(widget.loggedUser.id);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 24),
        CircleAvatar(
          backgroundColor: Colors.blue,
          minRadius: 80.0,
          child: CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage(widget.loggedUser.imagePath)),
        ),
        const SizedBox(height: 24),
        buildName(user),
        const SizedBox(height: 24),
        const NumbersWidget(),
        const SizedBox(height: 36),
        Center(
            child: ButtonWidget(
          text: 'Account Information',
          onClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfilePage(title: "Edit Profile",loggedUser: user)),
            ).whenComplete(() => setState(() {}));
          },
        )),
        const SizedBox(height: 12),
        Center(
            child: ButtonWidget(
          text: '        My Reviews        ',
          onClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReviewsScreen(loggedUser: user)),
            ).whenComplete(() => setState(() {}));
          },
        )),
        const SizedBox(height: 12),
        Center(child: ButtonWidget(
          text: '     Privacy Policy     ',
          onClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PrivacyPolicyScreen(loggedUser: user)),
            ).whenComplete(() => setState(() {}));
          },
        )),
      ],
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
}
