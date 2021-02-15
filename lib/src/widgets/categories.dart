import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/category.dart';

import 'package:food_delivery/src/widgets/commons.dart';
import 'package:food_delivery/src/widgets/custom_text.dart';

List<Category> categoriesList = [
  Category(name: 'Salad', image: 'salad.png'),
  Category(name: 'Steak', image: 'steak.png'),
  Category(name: 'Fast food', image: 'sandwich.png'),
  Category(name: 'Deserts', image: 'ice-cream.png'),
  Category(name: 'Sea food', image: 'fish.png'),
  Category(name: 'Beer', image: 'pint.png'),
];

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red[50], offset: Offset(4, 6), blurRadius: 20),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      'images/${categoriesList[index].image}',
                      width: 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: categoriesList[index].name,
                  size: 14,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
