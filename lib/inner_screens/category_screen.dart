import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/models/products_model.dart';
import 'package:flutter_application_1/providers/products_provider.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/back_widget.dart';
import 'package:flutter_application_1/widgets/empty_products_widget.dart';
import 'package:flutter_application_1/widgets/feed_items.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreen";
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    Color color = utils.color;

    final categoryName = ModalRoute.of(context)!.settings.arguments as String;

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsByCategories =
        productProviders.FindByCategory(categoryName);

    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: productsByCategories.isEmpty
          ? const EmptyProductWidget(
              text: 'No products belong to this category',
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        focusNode: _searchTextFocusNode,
                        controller: _searchTextController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 1)),
                            hintText: "What's in your mind",
                            prefixIcon: Icon(Icons.search),
                            suffix: IconButton(
                              onPressed: () {
                                _searchTextController!.clear();
                                _searchTextFocusNode.unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: _searchTextFocusNode.hasFocus
                                    ? Colors.red
                                    : color,
                              ),
                            )),
                      ),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.6),
                    children:
                        List.generate(productsByCategories.length, (index) {
                      return ChangeNotifierProvider.value(
                          value: productsByCategories[index],
                          child: FeedsWidget());
                    }),
                  )
                ],
              ),
            ),
    );
  }
}
