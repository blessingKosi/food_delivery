import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductServices {
  String collection = 'products';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then(
        (result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }

          return products;
        },
      );

  Future<List<ProductModel>> getProductsByRestaurant({String id}) async =>
      _firestore
          .collection(collection)
          .where('restaurantId', isEqualTo: id)
          .get()
          .then(
        (result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }

          return products;
        },
      );

  Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where('category', isEqualTo: category)
          .get()
          .then(
        (result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }

          return products;
        },
      );

  Future<List<ProductModel>> searchProducts({String productName}) {
    String searchKey = productName[0].toUpperCase() +
        productName.substring(1); // converting first character to uppercase
    return _firestore
        .collection(collection)
        .orderBy('name')
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then(
          (result) {
            List<ProductModel> products = [];
            for (DocumentSnapshot product in result.docs) {
              products.add(ProductModel.fromSnapshot(product));
            }
            return products;
          },
        );
  }
}
