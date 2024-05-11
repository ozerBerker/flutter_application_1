import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/inner_screens/product_details_screen.dart';
import 'package:flutter_application_1/services/global_methods.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_application_1/widgets/hearth_btn.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';

class ShoppingCartWidget extends StatefulWidget {
  const ShoppingCartWidget({super.key});

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    Color color = utils.color;

    return GestureDetector(
      onTap: () {
        GlobalMethods()
            .navigateTo(ctx: context, routeName: ProductDetails.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    height: size.width * 0.25,
                    width: size.width * 0.25,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: FancyShimmerImage(
                      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Title',
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Row(
                          children: [
                            _quantityController(
                              fct: () {
                                if (_quantityTextController.text == '1') {
                                  return;
                                }
                                setState(() {
                                  _quantityTextController.text =
                                      (int.parse(_quantityTextController.text) -
                                              1)
                                          .toString();
                                });
                              },
                              color: Colors.red,
                              icon: CupertinoIcons.minus,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: _quantityTextController,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide())),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty) {
                                      _quantityTextController.text = '1';
                                    } else {
                                      return;
                                    }
                                  });
                                },
                              ),
                            ),
                            _quantityController(
                              fct: () {
                                setState(() {
                                  _quantityTextController.text =
                                      (int.parse(_quantityTextController.text) +
                                              1)
                                          .toString();
                                });
                              },
                              color: Colors.green,
                              icon: CupertinoIcons.plus,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        HeartButton(),
                        TextWidget(
                          text: '\$0.29',
                          color: color,
                          textSize: 18,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}