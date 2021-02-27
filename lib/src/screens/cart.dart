import 'package:flutter/material.dart';
import 'package:food_delivery/src/helpers/style.dart';
//import 'package:food_delivery/src/models/products.dart';
import 'package:food_delivery/src/widgets/custom_text.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // ProductModel product = ProductModel(
  //   name: 'Cereals',
  //   price: 5.99,
  //   rating: 4.2,
  //   vendor: 'GoodFoods',
  //   wishList: true,
  //   image: '1.jpg',
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: black,
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: 'Shopping Bag',
          size: 22,
          weight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'images/shopping-bag.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                Positioned(
                  right: 7,
                  bottom: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: grey[400],
                          offset: Offset(2, 1),
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: CustomText(
                        text: '2',
                        color: red,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: white,
      body: ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 120,
          //     decoration: BoxDecoration(
          //       color: white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: red[100],
          //           offset: Offset(3, 6),
          //           blurRadius: 30,
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           'images/${product.image}',
          //           height: 120,
          //           width: 120,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             RichText(
          //               text: TextSpan(
          //                 children: [
          //                   TextSpan(
          //                     text: product.name + '\n',
          //                     style: TextStyle(
          //                       color: black,
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                   TextSpan(
          //                     text: '\$' + product.price.toString() + '\n',
          //                     style: TextStyle(
          //                       color: black,
          //                       fontSize: 17,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               width: 100,
          //             ),
          //             IconButton(icon: Icon(Icons.delete), onPressed: null)
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
