import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products_model.dart';
import 'package:flutter_application_1/providers/products_provider.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/back_widget.dart';
import 'package:flutter_application_1/widgets/empty_products_widget.dart';
import 'package:flutter_application_1/widgets/on_sale_widget.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    Color color = utils.color;

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> onSaleProducts = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: onSaleProducts.isEmpty
          ? const EmptyProductWidget(
              text: 'No product on sale yet!\nStay tuned',
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(onSaleProducts.length, (index) {
                return ChangeNotifierProvider.value(
                  value: onSaleProducts[index],
                  child: const OnSaleWidget(),
                );
              }),
            ),
    );
  }
}
