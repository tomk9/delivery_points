import 'package:delivery_points/models/Restaurant.dart';
import 'package:flutter/material.dart';

class SpotItem extends StatelessWidget {
  SpotItem({Key key, this.spot}) : super(key:key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text('${spot.deliveryTime.hour}:${spot.deliveryTime.minute}'),
    );
  }
}
