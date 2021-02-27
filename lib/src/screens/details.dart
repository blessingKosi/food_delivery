import 'package:flutter/material.dart';
import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/models/product.dart';
import 'package:food_delivery/src/helpers/style.dart';
//import 'package:food_delivery/src/providers/user.dart';
import 'package:food_delivery/src/screens/cart.dart';
import 'package:food_delivery/src/widgets/custom_text.dart';

//import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context);
    //final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: SafeArea(
        child:
            // app.isLoading ? Loading() :
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: widget.product.name, size: 26, weight: FontWeight.bold),
            CustomText(
                text: "\$${widget.product.price / 100}",
                size: 20,
                weight: FontWeight.w400),
            SizedBox(
              height: 10,
            ),
            CustomText(text: "Description", size: 18, weight: FontWeight.w400),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                style: TextStyle(color: grey, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 36,
                      ),
                      onPressed: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity -= 1;
                          });
                        }
                      }),
                ),
                GestureDetector(
                  onTap: () async {
                    //   app.changeLoading();
                    //   print("All set loading");

                    //  bool value =  await user.addToCard(product: widget.product, quantity: quantity);
                    //  if(value){
                    //    print("Item added to cart");
                    //    _key.currentState.showSnackBar(
                    //        SnackBar(content: Text("Added ro Cart!"))
                    //    );
                    //    user.reloadUserModel();
                    //    app.changeLoading();
                    //    return;
                    //  } else{
                    //    print("Item NOT added to cart");

                    //  }
                    //   print("lOADING SET TO FALSE");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20)),
                    child:
                        //  app.isLoading ? Loading() :
                        Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(
                        text: "Add $quantity To Cart",
                        color: white,
                        size: 22,
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 36,
                        color: red,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class Details extends StatefulWidget {
//   final ProductModel product;

//   const Details({@required this.product});
//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 300,
//               child: Stack(
//                 children: [
//                   Carousel(
//                     images: [
//                       AssetImage('images/${widget.product.image}'),
//                       AssetImage('images/${widget.product.image}'),
//                       AssetImage('images/${widget.product.image}'),
//                     ],
//                     dotBgColor: white,
//                     dotColor: grey,
//                     dotIncreasedColor: red,
//                     dotIncreaseSize: 1.2,
//                     autoplay: false,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.arrow_back_ios),
//                         color: black,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: Stack(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Stack(
//                                 children: [
//                                   Image.asset(
//                                     'images/shopping-bag.png',
//                                     width: 30,
//                                     height: 30,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               right: 5,
//                               bottom: 0,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: grey,
//                                       offset: Offset(2, 1),
//                                       blurRadius: 3,
//                                     )
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.only(left: 4, right: 4),
//                                   child: CustomText(
//                                     text: '2',
//                                     color: red,
//                                     size: 18,
//                                     weight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     right: 20,
//                     bottom: 55,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: grey[400],
//                             offset: Offset(2, 1),
//                             blurRadius: 3,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Icon(
//                           Icons.favorite,
//                           size: 22,
//                           color: red,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CustomText(
//               text: widget.product.name,
//               size: 26,
//               weight: FontWeight.bold,
//             ),
//             CustomText(
//               text: '\$' + widget.product.price.toString(),
//               size: 20,
//               color: red,
//               weight: FontWeight.w600,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.remove,
//                       size: 36,
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     color: red,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
//                       child: CustomText(
//                         text: 'Add To Cart',
//                         color: white,
//                         size: 24,
//                         weight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.add,
//                       color: red,
//                       size: 36,
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
