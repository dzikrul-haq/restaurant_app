import 'package:equatable/equatable.dart';

class RestaurantResult extends Equatable {
  const RestaurantResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  /// Kita perlu menambahkan fungsi toJson() untuk melakukan
  /// perubahan data dari model untuk ditampilkan menjadi JSON.
  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [error, message, count, restaurants];
}

class SearchResult extends Equatable {
  const SearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  @override
  List<Object?> get props => [error, founded, restaurants];
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  /// Kita perlu menambahkan fungsi toJson() untuk melakukan
  /// perubahan data dari model untuk ditampilkan menjadi JSON.
  ///
  /// Mengapa demikian? Karena untuk mengirimkan data dari notifikasi ke halaman
  /// tertentu pada parameter payload haruslah dalam bentuk String.
  /// Sehingga, kita perlu mengembalikan data terlebih dahulu dalam bentuk Json
  /// agar bisa mengirimkan data yang bersumber dari API kedalam parameter
  /// payload.
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating.toString()
      };
}
