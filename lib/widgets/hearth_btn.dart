import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/utils.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Color color = utils.color;

    return GestureDetector(
      onTap: () {
        print('Heath Button pressed.');
      },
      child: Icon(
        IconlyLight.heart,
        size: 22,
        color: color,
      ),
    );
  }
}
