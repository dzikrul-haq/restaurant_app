import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/routes.dart';
import 'package:restaurant_app/widgets/favorite_button.dart';

class RestaurantItem extends StatelessWidget {
  static const _url = 'https://restaurant-api.dicoding.dev/images/small';
  final Restaurant restaurant;

  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);
    const locationIcon = Icon(Icons.location_on, color: Colors.red);
    const starIcon = Icon(Icons.star, color: Colors.yellow);

    final TextStyle nameStyle = GoogleFonts.oxygen(
      color: const Color(0xFFE07265),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return ListTile(
      contentPadding: padding,
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          '$_url/${restaurant.pictureId}',
          width: 100,
          height: 120,
        ),
      ),
      trailing: FavoriteButton(item: restaurant),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name,
              style: nameStyle, semanticsLabel: restaurant.name),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              locationIcon,
              Text(restaurant.city,
                  semanticsLabel: AppLocalizations.of(context)!
                      .listPage_place_template(restaurant.city)),
            ],
          )
        ],
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          starIcon,
          Text(
            restaurant.rating.toString(),
            semanticsLabel: AppLocalizations.of(context)!
                .item_or_detail_rating(restaurant.rating.toString()),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, detailRestaurant,
            arguments: restaurant.id);
      },
    );
  }
}
