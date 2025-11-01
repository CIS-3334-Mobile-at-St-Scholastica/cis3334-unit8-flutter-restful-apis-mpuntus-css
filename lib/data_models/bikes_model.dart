// data_models/bikes_model.dart
// To parse this JSON data:
//
//     final bikesResponse = bikesResponseFromJson(jsonString);

import 'dart:convert';

BikesResponse bikesResponseFromJson(String str) =>
    BikesResponse.fromJson(json.decode(str));

String bikesResponseToJson(BikesResponse data) =>
    json.encode(data.toJson());

class BikesResponse {
  List<Network> networks;

  BikesResponse({required this.networks});

  factory BikesResponse.fromJson(Map<String, dynamic> json) =>
      BikesResponse(
        networks: List<Network>.from(
          json["networks"].map((x) => Network.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
  };
}

class Network {
  String id;
  String name;
  String href;
  List<String>? company;
  Location location;

  Network({
    required this.id,
    required this.name,
    required this.href,
    required this.location,
    this.company,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    name: json["name"],
    href: json["href"],
    company: json["company"] == null
        ? null
        : List<String>.from(json["company"].map((x) => x)),
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "href": href,
    "company": company == null
        ? []
        : List<dynamic>.from(company!.map((x) => x)),
    "location": location.toJson(),
  };
}

class Location {
  double latitude;
  double longitude;
  String city;
  String country;

  Location({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    city: json["city"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "city": city,
    "country": country,
  };
}
