import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _detailEndpoint = 'detail';
  static const String _searchEndpoint = 'search';
  static const String _listEndpoint = 'list';

  Future<RestaurantResult> list() async {
    final response = await http.get(Uri.parse('$_baseUrl/$_listEndpoint'));

    try {
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      }
    } on SocketException {
      if (kDebugMode) {
        print('No Internet Access');
      }
    } on HttpException {
      if (kDebugMode) {
        print('Not Found');
      }
    } on FormatException {
      if (kDebugMode) {
        print('Bad Response');
      }
    }

    throw Exception('Failed to load list');
  }

  Future<DetailResult> get(String id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$_detailEndpoint/$id'));

    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<SearchResult> search(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/$_searchEndpoint?q=$query'));

    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
