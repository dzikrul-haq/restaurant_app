import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/data_provider.dart';
import 'package:restaurant_app/utils/state_enum.dart';
import 'package:restaurant_app/widget/restaurant_item_widget.dart';

/// [RestaurantListPage] is the page that render list of Restaurant Recommendations.
class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: ChangeNotifierProvider<DataProvider>(
        create: (_) => DataProvider(null, null, service: ApiService()),
        child: Consumer<DataProvider>(
          builder: (context, state, _) {
            switch (state.state) {
              case ResultState.loading:
                return const Center(child: CircularProgressIndicator());
              case ResultState.hasData:
                var data = state.result.restaurants;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var restaurant = data[index];
                    return RestaurantItem(restaurant: restaurant);
                  },
                );
              case ResultState.noData:
                return Center(child: Text(state.message));
              case ResultState.error:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 30,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Text(
                        // AppLocalization merupakan fitur yang memungkinkan kita
                        // dapat membuat aplikasi support bahasa asing.
                        AppLocalizations.of(context)!.error,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
