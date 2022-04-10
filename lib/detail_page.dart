
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:restaurant_app/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurants_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

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
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.oxygen(
                        color: Color(0xFFE07265),
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_pin, color: Colors.red,),
                      Text(restaurant.city),
                    ],
                  ),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantWebView extends StatelessWidget {
  static const routeName = '/restaurant_web';

  final String url;

  const RestaurantWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}