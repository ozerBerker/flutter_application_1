import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/consts/consts.dart';
import 'package:mobile_app/consts/firebase_consts.dart';
import 'package:mobile_app/screens/auth/login.dart';
import 'package:mobile_app/screens/loading_manager.dart';
import 'package:mobile_app/services/global_methods.dart';
import 'package:mobile_app/services/utils.dart';
import 'package:mobile_app/widgets/auth_button.dart';
import 'package:mobile_app/widgets/back_widget.dart';
import 'package:mobile_app/widgets/google_auth_button.dart';
import 'package:mobile_app/widgets/text_widget.dart';
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

  bool _isLoading = false;
  void _forgotPasswordFCT() async {
    if (_emailTextController.text.isEmpty ||
        _emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email adress', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });

      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase().trim());
        Fluttertoast.showToast(
            msg: "An email has been sent to your email address",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: 16.0);
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final theme = utils.getTheme;
    Color color = utils.color;

    Size size = utils.getScreenSize;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
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
      ),
    );
  }
}
