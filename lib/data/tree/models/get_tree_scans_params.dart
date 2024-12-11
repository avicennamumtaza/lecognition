class GetTreeScansParams {
  final int treeId;
  // final String userId;

  GetTreeScansParams({
    required this.treeId,
    // required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'treeId': treeId,
      // 'userId': userId,
    };
  }
}