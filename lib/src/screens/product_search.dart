import 'package:flutter/material.dart';
import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/helpers/style.dart';
import 'package:food_delivery/src/providers/app.dart';
import 'package:food_delivery/src/providers/product.dart';
import 'package:food_delivery/src/screens/cart.dart';
import 'package:food_delivery/src/screens/details.dart';
import 'package:food_delivery/src/widgets/custom_text.dart';
import 'package:food_delivery/src/widgets/loading.dart';
import 'package:food_delivery/src/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CustomText(text: "Products", size: 20),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                changeScreen(context, CartScreen());
              }),
        ],
      ),
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Loading(),
                ],
              ),
            )
          : productProvider.productsSearched.length < 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: grey, size: 30),
                    SizedBox(height: 15),
                    Center(
                      child: CustomText(
                        text: 'No Products Found',
                        color: grey,
                        weight: FontWeight.w300,
                        size: 22,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: productProvider.productsSearched.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        changeScreen(
                            context,
                            Details(
                                product:
                                    productProvider.productsSearched[index]));
                      },
                      child: ProductWidget(
                          product: productProvider.productsSearched[index]),
                    );
                  },
                ),
    );
  }
}
