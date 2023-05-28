import 'package:flutter/material.dart';
import '../helpers/restaurant.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];
  RestaurantModel restaurant;

  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants =
        await _restaurantServices.searchRestaurant(restaurantName: name);
    print('RESTOS ARE: ${searchedRestaurants.length}');
    notifyListeners();
  }
}
