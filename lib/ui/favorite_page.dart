import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/theme.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/state_enum.dart';
import 'package:restaurant_app/widgets/restaurant_item_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.favoritePage_title,
            style: titleStyle),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, state, _) {
          switch (state.state) {
            case ResultState.loading:
              return Center(
                  child: Semantics(
                      child: const CircularProgressIndicator(),
                      label: AppLocalizations.of(context)!.loading));
            case ResultState.hasData:
              var data = state.favorites;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var restaurant = data[index];
                  return RestaurantItem(restaurant: restaurant);
                },
              );
            case ResultState.noData:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Semantics(
                      child: LottieBuilder.asset(
                        'assets/empty-list.json',
                        width: 200,
                        height: 200,
                      ),
                      label: AppLocalizations.of(context)!.empty,
                    ),
                    Text(state.message),
                  ],
                ),
              );
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
