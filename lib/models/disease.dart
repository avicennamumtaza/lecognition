import 'package:flutter/material.dart';

class Disease {
  final int diseaseId;
  final String diseaseName;
  final String description;
  // final DateTime createdAt;

  Disease({
    required this.diseaseId,
    required this.diseaseName,
    required this.description,
    // required this.createdAt,
  });

  // Convert a Disease object to a map to send it to the database
  Map<String, dynamic> toMap() {
    return {
      'diseaseId': diseaseId,
      'diseaseName': diseaseName,
      'description': description,
      // // 'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert a map from the database to a Disease object
  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      diseaseId: map['diseaseId'],
      diseaseName: map['diseaseName'],
      description: map['description'],
      // // createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
