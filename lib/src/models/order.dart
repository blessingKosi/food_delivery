import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = 'id';
  static const DESCRIPTION = 'description';
  static const CART = 'cart';
  static const USER_ID = 'userId';
  static const TOTAL = 'total';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';
  static const RESTAURANT_ID = 'restaurantId';

  String _id;
  String _description;
  String _userId;
  String _status;
  int _total;
  int _createdAt;
  String _restaurantId;

  // getters

  String get id => _id;
  String get description => _description;

  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;
  String get restaurantId => _restaurantId;

  // public variable
  List cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _description = snapshot.data()[DESCRIPTION];
    _total = snapshot.data()[TOTAL];
    _status = snapshot.data()[STATUS];
    _createdAt = snapshot.data()[CREATED_AT];
    _userId = snapshot.data()[USER_ID];
    _restaurantId = snapshot.data()[RESTAURANT_ID];
    cart = snapshot.data()[CART];
    
  }
}
