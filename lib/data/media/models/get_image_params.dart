class GetImageParams {
  GetImageParams({
    required this.url,
  });
  final String url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "url": url,
    };
  }
}
