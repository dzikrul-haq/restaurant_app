import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/restaurant.dart';

import 'detail_page.dart';

/// Display List of Restaurant
class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  /// See more on [https://medium.flutterdevs.com/keys-in-flutter-104fc01db48f]
  const RestaurantListPage({Key? key}) : super(key: key);

  /// Fungsi untuk mendapatkan daftar restoran secara asynchronous
  Future<List<Restaurant>> fetchRestaurant(String url) async {
    // gunakan [await] untuk mengambil data secara terpisah
    // await akan mengembalikan data kembali ke Future setelah tugas dikerjakan.
    var jsonText = await rootBundle.loadString(url);

    final Data data = dataFromJson(jsonText);
    final List<Restaurant> restaurants = data.restaurants;

    // jika tidak berisi
    if (restaurants.isEmpty) return [];

    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: fetchRestaurant('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          // Get data from restaurant model
          // error because data parsing error, learn more [https://docs.flutter.dev/development/data-and-backend/json]

          // jika data bernilai null, maka tampilkan error.
          if (snapshot.data == null) {
            return const Center(
              child: Text('No Data'),
            );
          }

          final List<Restaurant> restaurant = snapshot.data!;

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
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
