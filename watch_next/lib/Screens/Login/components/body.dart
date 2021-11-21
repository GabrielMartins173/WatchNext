// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:watch_next/Screens/Home/home_screen.dart';
import 'package:watch_next/Screens/Login/components/background.dart';
import 'package:watch_next/Screens/Login/login_screen.dart';
import 'package:watch_next/Screens/Login/login_service.dart';
import 'package:watch_next/Screens/SignUp/signup_screen.dart';
import 'package:watch_next/components/already_have_an_account_acheck.dart';
import 'package:watch_next/components/rounded_button.dart';
import 'package:watch_next/components/rounded_input_field.dart';
import 'package:watch_next/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../../database.dart';
//import 'package:watch_next/database.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String email = "";
    String password = "";
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                await WatchNextDatabase.recreateDB();
                if (await LoginService.signIn(email, password)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
