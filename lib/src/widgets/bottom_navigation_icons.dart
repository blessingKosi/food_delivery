import 'package:flutter/material.dart';

import 'custom_text.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;

  const BottomNavIcon({this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            'images/$image',
            width: 20,
            height: 20,
          ),
          SizedBox(
            height: 2.0,
          ),
          CustomText(
            text: name,
          ),
        ],
      ),
    );
  }
}
