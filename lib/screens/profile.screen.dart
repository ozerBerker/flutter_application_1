import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/dark_theme_provider.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(
                    text: 'Hi,   ',
                    style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                  TextSpan(
                      text: "My Name",
                      style: TextStyle(
                          color: color,
                          fontSize: 27,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("My name is Berker");
                        })
                ])),
            const SizedBox(
              height: 5,
            ),
            TextWidget(text: "test@gmail.com", color: color, textSize: 18),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            _listTiles(
              title: 'Adress',
              subtitle: 'Subtitle Here',
              icon: IconlyLight.profile,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: 'Orders',
              icon: IconlyLight.bag,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: 'Wishlist',
              icon: IconlyLight.heart,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: 'Viewed',
              icon: IconlyLight.show,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: 'Forgot Password',
              icon: IconlyLight.unlock,
              onPressed: () {},
              color: color,
            ),
            SwitchListTile(
              title: TextWidget(
                  text: themeState.getDarkTheme ? "Dark Mode" : "Light Mode",
                  color: color,
                  textSize: 18),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onChanged: (bool value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              },
              value: themeState.getDarkTheme,
            ),
            _listTiles(
              title: 'Logout',
              icon: IconlyLight.logout,
              onPressed: () {},
              color: color,
            )
          ],
        ),
      ),
    ));
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 18,
        isTitle: true,
      ),
      subtitle: TextWidget(text: subtitle ?? "", color: color, textSize: 14),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
