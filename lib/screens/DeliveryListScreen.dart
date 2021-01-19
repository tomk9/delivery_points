import 'package:delivery_points/components/SpotItem.dart';
import 'package:delivery_points/models/ReastaurantModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryListScreen extends StatefulWidget {
  DeliveryListScreen({Key key, this.status}) : super(key: key);
  final String status;

  @override
  _DeliveryListScreenState createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen>
    with AutomaticKeepAliveClientMixin<DeliveryListScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<RestaurantModel>(
      builder: (context, restaurant, child) =>
          restaurant.restaurantName == '' && restaurant.isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  child: ListView.builder(
                    itemCount: widget.status == 'UNDELIVERED'
                        ? restaurant.undeliveredSpots.length
                        : restaurant.deliveredSpots.length,
                    itemBuilder: (context, index) {
                      return SpotItem(
                        spot: widget.status == 'UNDELIVERED'
                            ? restaurant.undeliveredSpots[index]
                            : restaurant.deliveredSpots[index],
                        status: widget.status,
                      );
                    },
                  ),
                  onRefresh: _onRefresh,
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    await Provider.of<RestaurantModel>(context).fetchData();
  }
}
