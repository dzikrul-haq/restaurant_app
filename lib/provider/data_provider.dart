import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DataProvider extends ChangeNotifier {
  final ApiService service;
  String? query;
  String id;

  DataProvider(this.id, this.query, {required this.service}) {
    if (id != null) {
      _fetchDetail(id!);
    } else if (query != null) {
      _fetchRestaurantByQuery(query!);
    } else {
      _fetchAllRestaurant();
    }
  }

  late RestaurantResult _restaurantResult;
  late SearchResult _searchResult;
  late DetailResult _detailResult;
  late String _message = '';
  late final int _count = 0;
  late ResultState _state;

  String get message => _message;
  SearchResult get search => _searchResult;
  DetailResult get detail => _detailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;

      // Fungsi ini akan memberitahukan kepada widget yang
      // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
      notifyListeners();
      final restaurant = await service.list();

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;

        // Fungsi ini akan memberitahukan kepada widget yang
        // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;

        // Fungsi ini akan memberitahukan kepada widget yang
        // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;

      // Fungsi ini akan memberitahukan kepada widget yang
      // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchRestaurantByQuery(String query) async {
    try {
      _state = ResultState.Loading;

      // Fungsi ini akan memberitahukan kepada widget yang
      // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
      notifyListeners();
      final response = await service.search(query);

      if ((response.founded == 0) || (response.restaurants.isEmpty)) {
        _state = ResultState.NoData;


        // Fungsi ini akan memberitahukan kepada widget yang
        // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
        notifyListeners();
        return _message = 'No Data Available';
      } else {
        _state = ResultState.HasData;

        // Fungsi ini akan memberitahukan kepada widget yang
        // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
        notifyListeners();
        return _searchResult = response;
      }
    } catch (e) {
      _state = ResultState.Error;

      // Fungsi ini akan memberitahukan kepada widget yang
      // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;

      // Fungsi ini akan memberitahukan kepada widget yang
      // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
      notifyListeners();
      final detail = await service.get(id);

      if (detail.error == false) {
        _state = ResultState.HasData;

        // Fungsi ini akan memberitahukan kepada widget yang
        // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
        notifyListeners();
        return _detailResult = detail;
      }
    } catch (e) {
      _state = ResultState.Error;

      // Fungsi ini akan memberitahukan kepada widget yang
      // menggunakan state ini bahwa terjadi perubahan sehingga harus membangun ulang UI.
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
