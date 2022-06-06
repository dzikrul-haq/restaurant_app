import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/navigation.dart';
import 'package:restaurant_app/commons/theme.dart';
import 'package:restaurant_app/commons/utils.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(),
        ),
      ],
      child: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restaurants',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('id', ''),
              Locale('en', ''),
            ],
            locale: provider.locale,
            // TODO: implement dark theme after learn about shared preferences
            theme: lightTheme,
            builder: (context, child) {
              return CupertinoTheme(
                data: const CupertinoThemeData(
                  // TODO: implement dark theme after learn about shared preferences
                  brightness: Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            showSemanticsDebugger: false,
            home: const HomePage(),
            navigatorKey: navigatorKey,
            navigatorObservers: [routeObserver],
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case home:
                  return MaterialPageRoute(builder: (_) => const HomePage());
                case detailRestaurant:
                  final id = settings.arguments as String;
                  return MaterialPageRoute(
                      builder: (_) => RestaurantDetailPage(id: id),
                      settings: settings);
                default:
                  return MaterialPageRoute(
                    builder: (_) {
                      return const Scaffold(
                        body: Center(
                          child: Text('Page not found :('),
                        ),
                      );
                    },
                  );
              }
            },
          );
        },
      ),
    );
  }
}
