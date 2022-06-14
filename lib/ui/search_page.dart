import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/theme.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/restaurant_item_widget.dart';
import 'package:restaurant_app/widgets/restaurant_search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<SearchResult> restaurantSearch;
  List<Restaurant> restaurants = [];
  String query = '';
  Timer? deBouncer;

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (deBouncer != null) {
      deBouncer!.cancel();
    }
    deBouncer = Timer(duration, callback);
  }

  void searchRestaurant(String query) async => debounce(() async {
        if (query == "") {
          setState(() {
            this.query = query;
          });
          return;
        }
        restaurantSearch = ApiService(Client()).search(query);

        if (!mounted) return;
        setState(() {
          this.query = query;
        });
      });

  Widget buildSearch() => SearchWidget(
        hintText: AppLocalizations.of(context)!.search_something,
        text: query,
        onChanged: searchRestaurant,
      );

  Widget _buildQueryItem() {
    const loading = Center(child: CircularProgressIndicator());
    return FutureBuilder(
      future: restaurantSearch,
      builder: (
        context,
        AsyncSnapshot<SearchResult> snapshot,
      ) {
        var state = snapshot.connectionState;

        if (state == ConnectionState.waiting) {
          return const Expanded(child: loading);
        } else if (state == ConnectionState.done) {}
        if (snapshot.hasData) {
          if (snapshot.data!.restaurants.isEmpty) {
            return emptySearch();
          }
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data!.restaurants[index];
                return RestaurantItem(restaurant: restaurant);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  size: 30,
                  color: grey,
                ),
                Text(
                  AppLocalizations.of(context)!.error,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                size: 30,
                color: grey,
              ),
              Text(
                AppLocalizations.of(context)!.error,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget emptySearch() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              child: LottieBuilder.asset(
                'assets/empty-list.json',
                width: 200,
                height: 200,
              ),
              label: AppLocalizations.of(context)!.empty,
            ),
            Text(
              AppLocalizations.of(context)!.empty,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }

  Widget letsSearch() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Semantics(
              child: LottieBuilder.asset(
                'assets/ux-team.json',
                width: 200,
                height: 200,
              ),
              label: AppLocalizations.of(context)!.search_image_animation,
            ),
            Text(AppLocalizations.of(context)!.search_body),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.searchPage_title,
            style: titleStyle),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            query == "" ? letsSearch() : _buildQueryItem(),
          ],
        ),
      ),
    );
  }
}
