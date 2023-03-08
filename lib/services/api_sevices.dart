import 'dart:developer';

import 'package:chatgpt_app/models/models_model.dart';

import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");

      List tempModelsList = [];
      for (var value in jsonResponse["data"]) {
        tempModelsList.add(value);
        // log("Temp: ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(tempModelsList);
    } catch (error) {
      log("Error: $error");
      rethrow;
    }
  }
}
