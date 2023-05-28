import 'package:flutter/material.dart';
import 'package:food_delivery/src/helpers/order.dart';
import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/helpers/style.dart';
import 'package:food_delivery/src/models/cart_item.dart';
import 'package:food_delivery/src/providers/app.dart';
import 'package:food_delivery/src/providers/user.dart';
import 'package:food_delivery/src/screens/home.dart';

import 'package:food_delivery/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: 'Shopping Cart'),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.userModel.cart.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: red[100],
                      offset: Offset(3, 6),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        user.userModel.cart[index].image,
                        height: 120,
                        width: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: user.userModel.cart[index].name + '\n',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '\$${user.userModel.cart[index].price} \n\n',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Quantity: ',
                                  style: TextStyle(
                                    color: grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: user.userModel.cart[index].quantity
                                      .toString(),
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: red,
                            ),
                            onPressed: () async {
                              app.changeLoading();
                              bool value = await user.removeFromCart(
                                  cartItem: user.userModel.cart[index]);
                              if (value) {
                                user.reloadUserModel();

                                print("Item removed from cart");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Removed From Cart!"),
                                  ),
                                );
                                app.changeLoading();
                                return;
                              } else {
                                print('Item Was Not Removed');
                                app.changeLoading();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total: ',
                      style: TextStyle(
                        color: grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' \$${user.userModel.totalCartPrice}',
                      style: TextStyle(
                        color: primary,
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                // ignore: deprecated_member_use
                child: TextButton(
                  onPressed: () {
                    if (user.userModel.totalCartPrice == 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Your cart is empty',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text:
                                              'You will be charged \$${user.userModel.totalCartPrice} upon delivery!',
                                          size: 18,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      // ignore: deprecated_member_use
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          var uuid = Uuid();
                                          String id = uuid.v4();
                                          _orderServices.createOrder(
                                              userId: user.user.uid,
                                              id: id,
                                              description:
                                                  "Some random description",
                                              status: "complete",
                                              totalPrice:
                                                  user.userModel.totalCartPrice,
                                              cart: user.userModel.cart);
                                          for (CartItemModel cartItem
                                              in user.userModel.cart) {
                                            bool value =
                                                await user.removeFromCart(
                                                    cartItem: cartItem);
                                            if (value) {
                                              user.reloadUserModel();
                                              print("Item added to cart");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Removed from Cart!")));
                                            } else {
                                              print("ITEM WAS NOT REMOVED");
                                            }
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Order created!")));
                                          Navigator.pop(context);
                                          changeScreen(context, Home());
                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1BC0C5)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      // ignore: deprecated_member_use
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1BC0C5)),

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: CustomText(
                    text: 'Check out',
                    color: white,
                    weight: FontWeight.normal,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
