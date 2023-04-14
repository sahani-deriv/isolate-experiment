import 'dart:async';
import 'package:flutter/foundation.dart';

class Person {
  final String name;
  final int age;
  final String address;

  Person({required this.name, required this.age, required this.address});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      age: json['age'],
      address: json['address'],
    );
  }
  static Future<Person> fromBackgroundJson(Map<String, dynamic> json) async {
    return await compute(parsePersonJson, json);
  }

  static Person parsePersonJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      age: json['age'],
      address: json['address'],
    );
  }
}
