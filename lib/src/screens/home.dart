import 'package:flutter/material.dart';
import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/providers/product.dart';
import 'package:food_delivery/src/providers/restaurant.dart';
// import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/providers/user.dart';
import 'package:food_delivery/src/screens/cart.dart';
// import 'package:food_delivery/src/screens/bag.dart';

// import 'package:food_delivery/src/widgets/bottom_navigation_icons.dart';
//import 'package:food_delivery/src/widgets/categories.dart';

import 'package:food_delivery/src/helpers/style.dart';
import 'package:food_delivery/src/screens/category.dart';
import 'package:food_delivery/src/screens/restaurant.dart';
import 'package:food_delivery/src/widgets/categories.dart';
import 'package:food_delivery/src/widgets/featured_products.dart';
import 'package:food_delivery/src/widgets/restaurant.dart';

import 'package:provider/provider.dart';
import '../widgets/custom_text.dart';
import '../providers/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: 'Food App',
          size: 22,
          color: white,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: primary,
              ),
              accountName: CustomText(
                text: user.userModel?.name,
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel.email,
                color: grey,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: 'Home'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.fastfood),
              title: CustomText(text: 'Food I like'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.restaurant),
              title: CustomText(text: 'Liked restaurants'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: CustomText(text: "Settings"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                  top: 8,
                  bottom: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: red,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find food or restaurant',
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: Icon(
                      Icons.filter_list,
                      color: red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await productProvider.loadProductsByCategory(
                              categoryName:
                                  categoryProvider.categories[index].name);
                          changeScreen(
                            context,
                            CategoryScreen(
                              categoryModel: categoryProvider.categories[index],
                            ),
                          );
                        },
                        child: CategoryWidget(
                          category: categoryProvider.categories[index],
                        ),
                      );
                    })),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: "Featured",
                    size: 20,
                    color: grey,
                  ),
                  CustomText(
                    text: "see all",
                    size: 14,
                    color: primary,
                  ),
                ],
              ),
            ),
            Featured(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: "Popular restaurants",
                    size: 20,
                    color: grey,
                  ),
                  CustomText(
                    text: "see all",
                    size: 14,
                    color: primary,
                  ),
                ],
              ),
            ),
            Column(
              children: restaurantProvider.restaurants
                  .map((item) => GestureDetector(
                        onTap: () async {
                          await productProvider.loadProductsByRestaurant(
                              restaurantId: item.id);
                          changeScreen(
                              context,
                              RestaurantScreen(
                                restaurantModel: item,
                              ));
                        },
                        child: RestaurantWidget(
                          restaurant: item,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
