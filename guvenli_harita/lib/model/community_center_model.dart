// To parse this JSON data, do
//
//     final communityCenter = communityCenterFromJson(jsonString);

import 'dart:convert';

class CommunityCenter {
  CommunityCenter({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final List<Result> result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  factory CommunityCenter.fromRawJson(String str) => CommunityCenter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityCenter.fromJson(Map<String, dynamic> json) => CommunityCenter(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    targetUrl: json["targetUrl"],
    success: json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"],
    abp: json["__abp"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "targetUrl": targetUrl,
    "success": success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest,
    "__abp": abp,
  };
}

class Result {
  Result({
    required this.name,
    required this.address,
    required this.authorizedPersonnel,
    required this.phoneNumber,
    required this.longitude,
    required this.latitude,
    required this.cityId,
    required this.city,
    required this.id,
  });

  final String name;
  final String address;
  final String authorizedPersonnel;
  final String phoneNumber;
  final double longitude;
  final double latitude;
  final int cityId;
  final String city;
  final int id;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    address: json["address"],
    authorizedPersonnel: json["authorizedPersonnel"],
    phoneNumber: json["phoneNumber"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
    cityId: json["cityId"],
    city: json["city"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "authorizedPersonnel": authorizedPersonnel,
    "phoneNumber": phoneNumber,
    "longitude": longitude,
    "latitude": latitude,
    "cityId": cityId,
    "city": city,
    "id": id,
  };
}
