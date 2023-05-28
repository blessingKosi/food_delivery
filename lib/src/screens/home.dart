import 'package:flutter/material.dart';
import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/providers/app.dart';
import 'package:food_delivery/src/providers/product.dart';
import 'package:food_delivery/src/providers/restaurant.dart';
import 'package:food_delivery/src/providers/user.dart';
import 'package:food_delivery/src/screens/cart.dart';
import 'package:food_delivery/src/helpers/style.dart';
import 'package:food_delivery/src/screens/category.dart';
import 'package:food_delivery/src/screens/product_search.dart';
import 'package:food_delivery/src/screens/restaurant.dart';
import 'package:food_delivery/src/screens/restaurant_search.dart';
import 'package:food_delivery/src/screens/order.dart';
import 'package:food_delivery/src/widgets/categories.dart';
import 'package:food_delivery/src/widgets/featured_products.dart';
import 'package:food_delivery/src/widgets/loading.dart';
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
    // _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
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
                text: user?.userModel?.name ?? "username loading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                // text: user.userModel.email,
                text: user.userModel?.email ?? "email loading...",
                color: grey,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: 'Home'),
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(Icons.fastfood),
            //   title: CustomText(text: 'Food I like'),
            // ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(Icons.restaurant),
            //   title: CustomText(text: 'Liked restaurants'),
            // ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(Icons.settings),
            //   title: CustomText(text: "Settings"),
            // ),
            ListTile(
              onTap: () async {
                user.signOut();
              },
              leading: Icon(Icons.logout),
              title: CustomText(text: "Signout"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Loading()),
                ],
              ),
            )
          : SafeArea(
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
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              if (app.search == SearchBy.PRODUCTS) {
                                await productProvider.search(
                                    productName: pattern);
                                changeScreen(context, ProductSearchScreen());
                              } else {
                                await restaurantProvider.search(name: pattern);
                                changeScreen(context, RestaurantSearchScreen());
                              }

                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                              hintText: 'Find food or restaurant',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: 'Search by:',
                        color: grey,
                        weight: FontWeight.w300,
                      ),
                      DropdownButton<String>(
                        value: app.filterBy,
                        style: TextStyle(
                            color: primary, fontWeight: FontWeight.w300),
                        icon: Icon(
                          Icons.filter_list,
                          color: primary,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == 'Products') {
                            app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          } else {
                            app.changeSearchBy(
                                newSearchBy: SearchBy.RESTAURANTS);
                          }
                        },
                        items: <String>['Products', 'Restaurants']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CustomText(
                      text: "Categories",
                      size: 20,
                      color: grey,
                    ),
                  ),
                  Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider.categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                //app.changeLoading();
                                await productProvider.loadProductsByCategory(
                                    categoryName: categoryProvider
                                        .categories[index].name);
                                //app.changeLoading();
                                changeScreen(
                                  context,
                                  CategoryScreen(
                                    categoryModel:
                                        categoryProvider.categories[index],
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
                        // will have to make a list of all featured products soon...
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
                        // will have to make a list of all Popular restaurants soon...
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
                                app.changeLoading();
                                await productProvider.loadProductsByRestaurant(
                                    restaurantId: item.id);
                                app.changeLoading();
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
