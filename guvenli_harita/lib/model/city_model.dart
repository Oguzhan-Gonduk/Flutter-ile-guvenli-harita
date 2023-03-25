// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class City {
  City({
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

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
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
    required this.plateNumber,
    required this.name,
    required this.id,
  });

  final int plateNumber;
  final String name;
  final int id;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    plateNumber: json["plateNumber"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "plateNumber": plateNumber,
    "name": name,
    "id": id,
  };
}
