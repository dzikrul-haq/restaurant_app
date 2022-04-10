import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/restaurant.dart';

import 'detail_page.dart';

/// Display List of Restaurant
class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurants',
        ),
      ),
      body: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              // Get data from restaurant model
              // error because data parsing error, learn more [https://docs.flutter.dev/development/data-and-backend/json]

              final List<Restaurant> restaurant =
                  dataFromJson(snapshot.data!).restaurants;

              return ListView.builder(
                itemCount: restaurant.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurant[index]);
                },
              );
            },
          ),
      );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
          height: 120,
        ),
      ),
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant.name,
                style: GoogleFonts.oxygen(
                  color: Color(0xFFE07265),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
           Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               Icon(Icons.location_pin, color: Colors.red,),
               Text(restaurant.city),
             ],
           )
          ],
        ),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.yellow,),
          Text(restaurant.rating.toString()),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
