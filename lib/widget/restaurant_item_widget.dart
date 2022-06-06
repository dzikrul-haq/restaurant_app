import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/routes.dart';

/// [RestaurantItem] class is the Widget that used for display items
/// of [RestaurantListPage].
class RestaurantItem extends StatelessWidget {
  static const _url = 'https://restaurant-api.dicoding.dev/images/small';
  final Restaurant restaurant;

  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          '$_url/${restaurant.pictureId}',
          width: 100,
          height: 120,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name,
              style: GoogleFonts.oxygen(
                color: const Color(0xFFE07265),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              Text(restaurant.city),
            ],
          )
        ],
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.yellow),
          Text(restaurant.rating.toString()),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, detailRestaurant, arguments: restaurant.id);
      },
    );
  }
}
