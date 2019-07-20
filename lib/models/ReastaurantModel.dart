import 'package:delivery_points/models/Restaurant.dart';
import 'package:flutter/foundation.dart';

class RestaurantModel extends ChangeNotifier {
  Restaurant _restaurant;
  String restaurantName = '';
  List<Spot> deliveredSpots = List<Spot>();
  List<Spot> undeliveredSpots = List<Spot>();
  bool isLoading = true;
  bool isError = false;

  RestaurantModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      _restaurant = await fetchRestaurant();
      restaurantName = _restaurant.restaurantName;
      deliveredSpots = _restaurant.lunchSpots.spots
          .where((i) => i.status == 'DELIVERED')
          .toList()
            ..sort(sortComparator);
      undeliveredSpots = _restaurant.lunchSpots.spots
          .where((i) => i.status == 'UNDELIVERED')
          .toList()
            ..sort(sortComparator);
    } catch (error) {
      isError = true;
      print(error);
    }
    isLoading = false;
    notifyListeners();
  }

  int sortComparator(Spot s1, Spot s2) {
    return s1.deliveryTime.difference(s2.deliveryTime).inSeconds;
  }
}
