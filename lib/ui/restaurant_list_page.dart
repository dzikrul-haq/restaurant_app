import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/theme.dart';
import 'package:restaurant_app/provider/data_provider.dart';
import 'package:restaurant_app/utils/state_enum.dart';
import 'package:restaurant_app/widgets/restaurant_item_widget.dart';

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
        title: Text(AppLocalizations.of(context)!.title, style: titleStyle),
      ),
      body: Consumer<DataProvider>(
        builder: (context, state, _) {
          switch (state.state) {
            case ResultState.loading:
              return Center(
                  child: Semantics(
                      child: const CircularProgressIndicator(),
                      label: AppLocalizations.of(context)!.loading));
            case ResultState.hasData:
              var data = state.result.restaurants;
              return ListView.builder(
                semanticChildCount: data.length,
                addSemanticIndexes: true,
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
                      AppLocalizations.of(context)!.error,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
