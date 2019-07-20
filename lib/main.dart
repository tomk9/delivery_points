import 'package:delivery_points/models/ReastaurantModel.dart';
import 'package:delivery_points/screens/DeliveryListScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      builder: (context) => RestaurantModel(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punkty Dostawy',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const titles = ['Oczekujące', 'Dostarczone'];
  int _pageIndex = 0;
  PageController _pageController;
  String _title = titles[0];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantModel>(
      builder: (context, restaurant, child) => Scaffold(
        appBar: AppBar(
          title: Text(
              '${restaurant.restaurantName == '' ? '' : restaurant.restaurantName + ' - '}$_title'),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: restaurant.isLoading ? null : restaurant.fetchData,
            )
          ],
        ),
        body: PageView(
          children: <Widget>[
            DeliveryListScreen(
              status: 'UNDELIVERED',
            ),
            DeliveryListScreen(
              status: 'DELIVERED',
            ),
          ],
          controller: _pageController,
          onPageChanged: _onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              title: Text(titles[0]),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up),
              title: Text(titles[1]),
            ),
          ],
          currentIndex: _pageIndex,
          onTap: _navigationTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigationTapped(int pageIndex) {
    _pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
      this._title = titles[pageIndex];
    });
  }
}
