import 'package:delivery_points/models/Restaurant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotItem extends StatelessWidget {
  SpotItem({Key key, this.spot, this.status}) : super(key: key);

  final Spot spot;
  final String status;

  @override
  Widget build(BuildContext context) {
    final _color = status == 'UNDELIVERED' ? Colors.red : Colors.green;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              _color.shade900,
              _color.shade700,
            ],
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    spot.company,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${spot.deliveryTime.hour}:${spot.deliveryTime.minute}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        spot.address,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Miejsce lunchu: ${spot.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.directions),
                    onPressed: () =>
                        _launchDirections('${spot.company}, ${spot.address}'),
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchDirections(String address) async {
    String url = 'https://www.google.com/maps/dir/?api=1&destination=$address';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch Directions to $address');
    }
  }
}
