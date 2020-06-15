class ApiResponse {
  int get totalDataCount => body["pagination"]["total"];
  int get totalPageCount => body["pagination"]["total_pages"];
  List get data => body["data"];
  bool get allGood => errors.length == 0;
  int code;
  String message;
  Map<String, dynamic> body;
  List errors;

  ApiResponse({
    this.code,
    this.message,
    this.body,
    this.errors,
  });
}
