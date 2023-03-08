import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModelsModel {
  final String root;
  final int created;
  final String id;

  ModelsModel({required this.root, required this.created, required this.id});

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        root: json["root"],
        created: json["created"],
      );

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((e) => ModelsModel.fromJson(e)).toList();
  }
}
