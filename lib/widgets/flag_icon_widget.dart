import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/localization.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({Key? key}) : super(key: key);

  String getLanguageAccessibility(BuildContext context, String languageCode) {
    switch (languageCode) {
      case "en":
        return AppLocalizations.of(context)!.settingsPage_localeItem2;
      case "id":
      default:
        return AppLocalizations.of(context)!.settingsPage_localeItem1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: Text(
          Localization.getFlag(AppLocalizations.of(context)!.code),
          style: Theme.of(context).textTheme.headline4,
          semanticsLabel: getLanguageAccessibility(
              context, AppLocalizations.of(context)!.code),
        ),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          final accFlag =
              getLanguageAccessibility(context, locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headline4,
                semanticsLabel: accFlag,
              ),
            ),
            onTap: () {
              final provider =
                  Provider.of<PreferenceProvider>(context, listen: false);
              provider.setLocale(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
