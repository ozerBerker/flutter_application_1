import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/inner_screens/feed_screen.dart';
import 'package:flutter_application_1/inner_screens/on_sale_screen.dart';
import 'package:flutter_application_1/provider/dark_theme_provider.dart';
import 'package:flutter_application_1/services/global_methods.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/feed_items.dart';
import 'package:flutter_application_1/widgets/on_sale_widget.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    Color color = utils.color;

    GlobalMethods globalMethods = GlobalMethods();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Consts.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Consts.offerImages.length,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.red)),
                control: const SwiperControl(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextButton(
                onPressed: () {
                  GlobalMethods().navigateTo(
                      ctx: context, routeName: OnSaleScreen.routeName);
                },
                child: TextWidget(
                    text: 'View All',
                    maxLines: 1,
                    color: Colors.blue,
                    textSize: 20)),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'On Sale'.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.24,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return const OnSaleWidget();
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Our Product',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  // const Spacer(),
                  TextButton(
                      onPressed: () {
                        GlobalMethods().navigateTo(
                            ctx: context, routeName: FeedScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'Browse All',
                        color: Colors.blue,
                        textSize: 20,
                        maxLines: 1,
                      )),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(4, (index) {
                return const FeedsWidget();
              }),
            )
          ],
        ),
      ),
    );
  }
}
