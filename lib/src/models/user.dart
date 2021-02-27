import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const ID = 'id';
  //static const LIKED_FOOD = 'likedFood';
  //static const Liked_Restaurants = 'likedRestaurants';
  static const STRIPE_ID = "stripeId";

  String _name;
  String _email;
  String _id;
  //List _likedFood;
  //List _likedRestaurants;
  String _stripeId;

  //getters

  String get name => _name;
  String get email => _email;
  String get id => _id;
  //List get likedFood => _likedFood;
  //List get likedRestaurants => _likedRestaurants;
  String get stripeId => _stripeId;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    //_likedFood = snapshot.data()[LIKED_FOOD] ?? [];
    //_likedRestaurants = snapshot.data()[Liked_Restaurants] ?? [];
    _stripeId = snapshot.data()[STRIPE_ID];
  }
}
