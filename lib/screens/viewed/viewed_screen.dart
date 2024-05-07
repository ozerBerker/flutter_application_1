import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/orders/order_widget.dart';
import 'package:flutter_application_1/screens/viewed/viewed_widget.dart';
import 'package:flutter_application_1/services/global_methods.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/back_widget.dart';
import 'package:flutter_application_1/widgets/empty_screen.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ViewedScreen extends StatelessWidget {
  static const routeName = '/ViewedScreen';
  const ViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Color color = utils.color;

    bool _isEmpty = true;

    if (_isEmpty == true) {
      return const EmptyScreen(
        title: 'Your history is empty',
        subtitle: 'No products has been viewed yet!',
        buttonText: 'Shop now',
        imagePath: 'assets/images/history.png',
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: const BackWidget(),
            elevation: 0,
            centerTitle: true,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            title: TextWidget(
              text: 'History',
              color: color,
              textSize: 24,
              isTitle: true,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    GlobalMethods().warningDialog(
                        title: 'Empty your cart?',
                        subtitle: 'Are you sıre?',
                        fct: () {},
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ))
            ],
          ),
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: ViewedWidget(),
                );
              })));
    }
  }
}
