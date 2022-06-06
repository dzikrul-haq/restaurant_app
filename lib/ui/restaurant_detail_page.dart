import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail.dart';
import 'package:restaurant_app/provider/data_provider.dart';
import 'package:restaurant_app/utils/state_enum.dart';
import 'package:restaurant_app/widget/choice_chip_bar_item.dart';

/// [RestaurantDetailPage] merupakan kelas yang diakses apabila user mengklik salah satu
/// item pada [RestaurantListPage] menampilkan keterangan dan daftar menu yang
/// dimiliki oleh restoran tersebut
class RestaurantDetailPage extends StatefulWidget {
  static const String routeName = '/restaurant_detail_page';
  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  static const _url = 'https://restaurant-api.dicoding.dev/images/small';
  var idSelected = 0;

  @override
  Widget build(BuildContext context) {
    // Change notifier berguna untuk mendaftarkan provider yang digunakan
    // oleh Widget Consumer.
    return ChangeNotifierProvider<DataProvider>(
      create: (_) => DataProvider(widget.id, null, service: ApiService()),
      child: _renderView(),
    );
  }

  // List Chip untuk membuat tab food dan drinks
  Row listChip(Menus menu) {
    foods.addAll(menu.foods);
    drinks.addAll(menu.drinks);

    return Row(
      mainAxisSize: MainAxisSize.max,
      // Membagi data yang diterima pada JSON.
      children: chipBarList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(item.title),
                selected: idSelected == item.id,
                onSelected: (_) => setState(() => idSelected = item.id),
              ),
            ),
          )
          .toList(),
    );
  }

  // Aksi apabila user mengklik salah satu chip yang tersedia
  Widget _actionButton(BuildContext context, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, left: 21),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
            // semantic label memungkinkan user dengan kebutuhan khusus dapat
            // mengakses aplikasi ini
            semanticLabel: AppLocalizations.of(context)!.back_to_list,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  // Menampilkan data detail restoran
  Widget _renderView() {
    // Consumer berarti Widget ini mengambil data dari Provider dengan nama
    // Restaurant Provider yang membawa context
    return Consumer<DataProvider>(
      // Context berarti unit view yang dibawa, state bearti status dari providernya
      builder: (context, state, _) {
        // Status dari provider yang sedang Loading
        switch (state.state) {
          case ResultState.loading:
            return Scaffold(
              appBar:
                  AppBar(title: Text(AppLocalizations.of(context)!.loading)),
              body: const Center(child: CircularProgressIndicator()),
            );
          case ResultState.hasData:
            return Scaffold(body: _detailView(state.detail.detail));
          case ResultState.noData:
            return Container();
          case ResultState.error:
            return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.error),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 50),
                    Text(AppLocalizations.of(context)!.error),
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  Widget currentTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: chipBarList[idSelected].bodyWidget,
    );
  }

  Widget _detailView(Detail restaurant) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Stack memungkinkan mengatur Widget Secara Vertical
            // pada sumbu Z (menghadap ke arah pengguna)
            Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                // Hero Memungkinkan animasi pergerakan dinamis pada Widget
                Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    '$_url/${restaurant.pictureId}',
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: _actionButton(
                    context,
                    () => Navigator.pop(context),
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  child: FavoriteButton(),
                ),
                Container(
                  height: 21,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(52),
                      topRight: Radius.circular(52),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: GoogleFonts.poppins(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.25,
                            color: const Color(0xFFD74141),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            const Icon(Icons.pin_drop, color: Colors.red),
                            Text(restaurant.city,
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                        Text(
                          restaurant.address,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.star,
                            size: 43, color: Color(0xFFFFD700)),
                        Text(
                          restaurant.rating.toString(),
                          semanticsLabel: AppLocalizations.of(context)!
                              .item_or_detail_rating(
                                  restaurant.rating.toString()),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.detailPage_description,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 21),
                  Text(
                    AppLocalizations.of(context)!.detailPage_menu,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: listChip(restaurant.menus),
            ),
            currentTab(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ],
        ),
      ),
    );
  }
}

/// [FavoriteButton] hanya pemanis setidaknya untuk pada submisi kali ini.
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  // Membuat status favori
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Mengubah status favorit (cara yang tidak disarankan)
      onTap: () => setState(() {
        isFavorited = !isFavorited;
      }),
      child: Padding(
        padding: const EdgeInsets.only(top: 21, right: 21),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: isFavorited
              ? Icon(
                  Icons.favorite,
                  color: Theme.of(context).iconTheme.color,
                  semanticLabel: AppLocalizations.of(context)!
                      .listPage_Item_favorite_false,
                )
              : Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).iconTheme.color,
                  semanticLabel:
                      AppLocalizations.of(context)!.listPage_Item_favorite_true,
                ),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
