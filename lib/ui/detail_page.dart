import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:webview_flutter/webview_flutter.dart';


class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurants_detail';
  final Restaurant data;

  const RestaurantDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RestaurantDetailPageState();
}


class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late final Restaurant restaurant;

  @override
  void initState() {
    restaurant = widget.data;
    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.oxygen(
                        color: const Color(0xFFE07265),
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      Text(restaurant.city),
                    ],
                  ),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                ],
              ),
            ),


            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColor),
              child: TabBar(
                controller: _controller,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.fastfood),
                    text: 'Foods',
                  ),
                  Tab(
                    icon: Icon(Icons.local_drink),
                    text: 'Drinks',
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 300.0,
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Card(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.check),
                          title: Text(restaurant.menus.foods[index].name),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListView.builder(
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.check),
                          title: Text(restaurant.menus.drinks[index].name),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

