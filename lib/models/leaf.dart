
class Leaf {
  final int leafId;
  final int userId;
  final String imagePath;
  final DateTime uploadDate;

  Leaf({
    required this.leafId,
    required this.userId,
    required this.imagePath,
    required this.uploadDate,
  });

  // Convert a Leaf object to a map to send it to the database
  Map<String, dynamic> toMap() {
    return {
      'leafId': leafId,
      'userId': userId,
      'imagePath': imagePath,
      'uploadDate': uploadDate.toIso8601String(),
    };
  }

  // Convert a map from the database to a Leaf object
  factory Leaf.fromMap(Map<String, dynamic> map) {
    return Leaf(
      leafId: map['leafId'],
      userId: map['userId'],
      imagePath: map['imagePath'],
      uploadDate: DateTime.parse(map['uploadDate']),
    );
  }
}
