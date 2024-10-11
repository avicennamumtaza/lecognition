import 'package:flutter/material.dart';

class Diagnosis {
  final int diagnosisId;
  final int leafId;
  final int diseaseId;
  final DateTime diagnosisDate;
  final double confidenceLevel;

  Diagnosis({
    required this.diagnosisId,
    required this.leafId,
    required this.diseaseId,
    required this.diagnosisDate,
    required this.confidenceLevel,
  });

  // Convert a Diagnosis object to a map to send it to the database
  Map<String, dynamic> toMap() {
    return {
      'diagnosisId': diagnosisId,
      'leafId': leafId,
      'diseaseId': diseaseId,
      'diagnosisDate': diagnosisDate.toIso8601String(),
      'confidenceLevel': confidenceLevel,
    };
  }

  // Convert a map from the database to a Diagnosis object
  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      diagnosisId: map['diagnosisId'],
      leafId: map['leafId'],
      diseaseId: map['diseaseId'],
      diagnosisDate: DateTime.parse(map['diagnosisDate']),
      confidenceLevel: map['confidenceLevel'],
    );
  }
}