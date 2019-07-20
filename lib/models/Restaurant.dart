import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Spot {
  final int lunchSpotId;
  final String name;
  final String status;
  final String address;
  final String company;
  final DateTime deliveryTime;

  Spot(
      {this.lunchSpotId,
      this.name,
      this.status,
      this.address,
      this.company,
      this.deliveryTime});

  factory Spot.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat.Hm();
    return Spot(
        lunchSpotId: json['lunchSpotId'],
        name: json['name'],
        status: json['status'],
        address: json['address'],
        company: json['company'],
        deliveryTime: dateFormat.parse(json['deliveryTime']));
  }
}

class SpotsList {
  final List<Spot> spots;

  SpotsList({this.spots});

  factory SpotsList.fromJson(List<dynamic> json) {
    List<Spot> spots = List<Spot>();
    spots = json.map((item) => Spot.fromJson(item)).toList();

    return SpotsList(
      spots: spots,
    );
  }
}

class Restaurant {
  final String restaurantName;
  final SpotsList lunchSpots;

  Restaurant({this.restaurantName, this.lunchSpots});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantName: json['restaurantName'],
      lunchSpots: SpotsList.fromJson(json['lunchSpots']),
    );
  }
}

Future<Restaurant> fetchRestaurant() async {
  final response =
      await http.get('http://www.mocky.io/v2/5d31d99933000068007ba497');
  Restaurant restaurant;
  if (response.statusCode == 200) {
    restaurant =
        Restaurant.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return restaurant;
  } else {
    throw Exception('Failed to fetch records');
  }
}
