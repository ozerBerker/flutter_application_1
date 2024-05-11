import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/services/global_methods.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/auth_button.dart';
import 'package:flutter_application_1/widgets/back_widget.dart';
import 'package:flutter_application_1/widgets/google_auth_button.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgotPasswordScreen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  void _forgotPasswordFCT() async {}

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final theme = utils.getTheme;
    Color color = utils.color;

    Size size = utils.getScreenSize;
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            duration: 800,
            autoplayDelay: 6000,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Consts.authImagesPaths[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
            itemCount: Consts.authImagesPaths.length,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  BackWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Forgot password',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailTextController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Emaill address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthButton(fct: _forgotPasswordFCT, buttonText: 'Reset Now')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
