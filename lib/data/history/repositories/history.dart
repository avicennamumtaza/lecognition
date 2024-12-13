import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/diagnosis_mapper.dart';
import 'package:lecognition/common/helper/mapper/disease_mapper.dart';
import 'package:lecognition/common/helper/mapper/history_mapper.dart';
import 'package:lecognition/data/disease/sources/disease_api_service.dart';
import 'package:lecognition/data/history/sources/history_api_service.dart';
import 'package:lecognition/domain/diagnozer/entities/diagnosis.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/history/entities/history.dart';
import 'package:lecognition/domain/history/repositories/history.dart';
import 'package:lecognition/service_locator.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  @override
  Future<Either> getUserHistories() async {
    var data = await sl<HistoryApiService>().getUserHistories();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        try {
          // Validasi apakah data adalah String dan mencoba decode JSON
          if (data is String) {
            print("Raw API Response: $data");

            // Pastikan respons JSON valid
            data = jsonDecode(data);
          }

          // Validasi bahwa data adalah List
          if (data is! List) {
            throw FormatException(
                "Unexpected data format: ${data.runtimeType}");
          }

          // Proses data menjadi entitas
          final treeScans = data
              .map(
                (item) => HistoryMapper.toEntity(
                  HistoryEntity.fromJson(item),
                ),
              )
              .toList();

          print("Processed Tree Scans: $treeScans");
          return Right(treeScans);
        } catch (e) {
          print("Error parsing response: $e");
          return Left("Failed to parse API response: $e");
        }
      },
    );
  }
}
