import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderModel {
  static const ID = 'id';
  static const DESCRITION = 'description';
  static const PRODUCT_ID = 'productId';
  static const USER_ID = 'userId';
  static const AMOUNT = 'amount';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';

  String _id;
  String _description;
  String _productId;
  String _userId;
  String _status;
  int _amount;
  int _createdAt;

  // getters

  String get id => _id;
  String get description => _description;
  String get productId => _productId;
  String get userId => _userId;
  String get status => _status;
  int get price => _amount;
  int get createdAt => _createdAt;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _description = snapshot.data()[ErrorDescription];
    _productId = snapshot.data()[PRODUCT_ID];
    _amount = snapshot.data()[AMOUNT];
    _status = snapshot.data()[STATUS];
    _createdAt = snapshot.data()[CREATED_AT];
    _userId = snapshot.data()[USER_ID];
  }
}
