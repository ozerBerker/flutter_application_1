import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/consts/theme_data.dart';
import 'package:flutter_application_1/inner_screens/feed_screen.dart';
import 'package:flutter_application_1/inner_screens/on_sale_screen.dart';
import 'package:flutter_application_1/inner_screens/product_details_screen.dart';
import 'package:flutter_application_1/provider/dark_theme_provider.dart';
import 'package:flutter_application_1/screens/bottom_bar.dart';
import 'package:flutter_application_1/screens/orders/order_screen.dart';
import 'package:flutter_application_1/screens/viewed/viewed_screen.dart';
import 'package:flutter_application_1/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const BottomBarScreen(),
            routes: {
              OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
              FeedScreen.routeName: (ctx) => const FeedScreen(),
              ProductDetails.routeName: (ctx) => const ProductDetails(),
              WishlistScreen.routeName: (ctx) => const WishlistScreen(),
              OrderScreen.routeName: (ctx) => const OrderScreen(),
              ViewedScreen.routeName: (ctx) => const ViewedScreen(),
            });
      }),
    );
  }
}
