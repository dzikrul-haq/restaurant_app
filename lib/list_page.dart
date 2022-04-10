import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

          final List<Restaurant> restaurant = dataFromJson(snapshot.data!).restaurants;

          return ListView.builder(
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, restaurant[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
        ),
      ),
      title: Text(
        restaurant.name,
      ),
      subtitle: Text(restaurant.rating.toString()),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
