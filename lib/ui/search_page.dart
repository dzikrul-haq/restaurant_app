import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

/// [SearchPage] adalah kelas yang dipanggil apabila user mengklik fitur
/// Search pada [RestaurantListPage] memungkinkan user mencari restaurant.
class SearchPage extends StatefulWidget {
  static const String routeName = "/search";

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<SearchResult> restaurantSearch;
  List<Restaurant> restaurants = [];
  String query = '';
  Timer? deBouncer;

  // Debounce untuk menunggu inputan user, jika tidak ada input
  // lebih dari 1 detik, lakukan akses pencarian melalui callback
  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (deBouncer != null) {
      deBouncer!.cancel();
    }
    deBouncer = Timer(duration, callback);
  }

  // Fungsi untuk mengakses API untuk mencari data dengan melalui
  // inputan callback debounce
  void searchRestaurant(String query) async => debounce(() async {
    if (query == "") {
      setState(() {
        this.query = query;
      });
      return;
    }

    restaurantSearch = ApiService().search(query);

    if (!mounted) return;
    setState(() {
      this.query = query;
    });
  });

  // Widget untuk Search
  Widget buildSearch() => SearchWidget(
    hintText: AppLocalizations.of(context)!.search_something,
    text: query,
    onChanged: searchRestaurant,
  );

  // Widget daftar item pencarian
  Widget _buildQueryItem() {
    // Menggunakan FutureBuilder karena menunggu output dari API
    return FutureBuilder(
      // Mengakses Future restaurantSearch
      future: restaurantSearch,
      builder: (
          context,
          // Mirip dengan Provider, AsyncSnapshot adalah callback yang didapat dari Future
          AsyncSnapshot<SearchResult> snapshot,
          ) {
        // Mendapatkan Status dari snapshot
        var state = snapshot.connectionState;

        // Jika koneksi snapshot dalam keadaan loading / waiting
        if (state == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        }
        // Jikaa koneksi telah selesai
        else if (state == ConnectionState.done) {}

        // jika snapshot yang dipanggil mempunyai data
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data!.restaurants[index];
                return CustomListItem(restaurant: restaurant);
              },
            ),
          );
        }
        // Jika snapshot yang dipanggil gagal mendapatkan data
        else if (snapshot.hasError) {
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

        // Bentuk default / Loading dari Snapshot
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).iconTheme.color,
                        // semantic label memungkinkan user dengan kebutuhan khusus dapat
                        // mengakses aplikasi ini
                        semanticLabel:
                        AppLocalizations.of(context)!.back_to_list,
                      ),
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.searchPage_title,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD74141),
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      )),
                ],
              ),
            ),
            buildSearch(),
            // Fungsi ini namanya ternary mirip seperti if else
            // tanda (?) merupakan pertanyaan dari kondisi query
            // setelah tanda tanya merupakan bentuk true dari jawaban
            // dan setelah (:) merupakan bentuk false dari jawaban.
            query == "" ? const SizedBox(height: 20) : _buildQueryItem(),
          ],
        ),
      ),
    );
  }
}
