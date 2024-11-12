class BookmarkDiseaseParams {
  BookmarkDiseaseParams({
    required this.diseaseId,
    required this.date,
    // required this.password,
  });
  final int diseaseId;
  final DateTime date;
  // final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "disease": diseaseId,
      "date": date,
    };
  }
}