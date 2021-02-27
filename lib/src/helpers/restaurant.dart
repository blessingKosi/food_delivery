import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class RestaurantServices {
  String collection = 'restaurants';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async =>
      _firestore.collection(collection).get().then((result) {
        List<RestaurantModel> restaurants = [];
        for (DocumentSnapshot restaurant in result.docs) {
          restaurants.add(RestaurantModel.fromSnapsot(restaurant));
        }

        return restaurants;
      });

  Future<RestaurantModel> getRestaurantById({String id}) => _firestore
          .collection(collection)
          .doc(id.toString())
          .get()
          .then((document) {
        return RestaurantModel.fromSnapsot(document);
      });
}
