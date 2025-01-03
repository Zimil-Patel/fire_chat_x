import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

class JsonService {
  JsonService._instance();

  static JsonService jsonService = JsonService._instance();

  Future<dynamic> getFromJson(String fileName) async {
    try {
      final stringData =
          await rootBundle.loadString('assets/json/$fileName.json');
      final data = jsonDecode(stringData);
      log("Fetched json data successfully...");
      return data;
    } catch (e) {
      log("Failed to fetch json data!");
    }

    return "fail";
  }
}
