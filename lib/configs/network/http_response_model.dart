class HttpResponseModel<T> {
  int? statusCode;
  T? data;
  String? status;
  String? message;

  HttpResponseModel({
    this.statusCode,
    this.data,
    this.status,
    this.message,
});

  factory HttpResponseModel.fromJson(Map<String, dynamic> json) {
    return HttpResponseModel(
      statusCode: json['statusCode'],
      data: json['data'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode' : statusCode,
      'data' : data,
      'status' : status,
      'message' : message,
    };
  }
}