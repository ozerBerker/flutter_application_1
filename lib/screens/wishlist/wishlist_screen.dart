import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/wishlist/wishlist_widget.dart';
import 'package:flutter_application_1/services/global_methods.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/back_widget.dart';
import 'package:flutter_application_1/widgets/empty_screen.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Color color = utils.color;

    bool _isEmpty = true;

    if (_isEmpty == true) {
      return const EmptyScreen(
        title: 'Your wishlist is empty',
        subtitle: 'Explore more and shortlist some items',
        buttonText: 'Add a wish',
        imagePath: 'assets/images/cart.png',
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const BackWidget(),
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          title: TextWidget(
            text: 'Wishlists (2)',
            color: color,
            textSize: 22,
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
        body: MasonryGridView.count(
          crossAxisCount: 2,
          // mainAxisSpacing: 16,
          // crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ),
      );
    }
  }
}
