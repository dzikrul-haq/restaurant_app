import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/theme.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/widgets/toast.dart';

class FavoriteButton extends StatefulWidget {
  final Restaurant item;

  const FavoriteButton({Key? key, required this.item}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(builder: (context, state, child) {
      return Consumer<DatabaseProvider>(
        builder: (context, provider, child) => FutureBuilder<bool>(
            future: provider.isFavorite(widget.item.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;

              String buttonLabel = isFavorite
                  ? AppLocalizations.of(context)!.favoriteButton_remove
                  : AppLocalizations.of(context)!.favoriteButton_add;

              Icon iconSprite = isFavorite
                  ? Icon(Icons.favorite, semanticLabel: buttonLabel, color: red)
                  : Icon(Icons.favorite_outline, semanticLabel: buttonLabel);

              Color containerColor = isFavorite ? primaryColor : grey;

              return InkWell(
                onTap: () => setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    provider.addFavorite(widget.item);
                    toast(AppLocalizations.of(context)!.favorite_added);
                  } else {
                    provider.removeFavorite(widget.item.id);
                    toast(AppLocalizations.of(context)!.favorite_removed);
                  }
                }),
                child: Container(
                    padding: const EdgeInsets.only(right: 4),
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(width: 0.8, color: grey200),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: iconSprite),
              );
            }),
      );
    });
  }
}
